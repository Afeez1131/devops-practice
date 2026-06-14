#!/bin/bash
LB_URL="http://web01lb-996173421.us-east-1.elb.amazonaws.com/"
THRESHOLD=37.5
DATAPOINTS=15
INTERVAL=60  # 1 minute per datapoint

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

    # Avoid division by zero
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
