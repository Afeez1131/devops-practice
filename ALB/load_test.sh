#!/bin/bash
LB_URL="http://web01lb-996173421.us-east-1.elb.amazonaws.com/"
# Must match the RequestCountPerTarget threshold set on the ALB target group's scaling policy
THRESHOLD=37.5
# CloudWatch needs at least 3 datapoints in a row above threshold to trigger scale-out;
# 15 gives enough signal while keeping total run time under 15 minutes
DATAPOINTS=15
INTERVAL=60  # 1 minute per datapoint — aligns with CloudWatch's minimum metric resolution

echo "Starting load test - tracking RequestCountPerTarget over $DATAPOINTS datapoints..."

for ((dp=1; dp<=DATAPOINTS; dp++)); do
    START=$(date +%s)

    # Send 200 concurrent requests
    for i in {1..200}; do
        curl -s -o /dev/null "$LB_URL" &
    done
    wait

    END=$(date +%s)
    DURATION=$(( END - START ))

    # Guard: all 200 requests can complete in <1s on a fast connection, making DURATION=0
    if (( DURATION == 0 )); then DURATION=1; fi

    # Requests per second in this datapoint window
    RPS=$(echo "scale=2; 200 / $DURATION" | bc)

    echo "Datapoint $dp/$DATAPOINTS | Requests: 200 | Duration: ${DURATION}s | RPS: $RPS"

    # Check if we're under threshold
    if (( $(echo "$RPS < $THRESHOLD" | bc -l) )); then
        echo "  ✓ Below threshold ($RPS < $THRESHOLD)"
    else
        echo "  ✗ Above threshold ($RPS >= $THRESHOLD)"
    fi

    # Wait before next datapoint (skip wait on last iteration)
    if (( dp < DATAPOINTS )); then
        echo "  Waiting ${INTERVAL}s before next datapoint..."
        sleep $INTERVAL
    fi
done

echo ""
echo "Done. Check AWS CloudWatch for RequestCountPerTarget metrics."
