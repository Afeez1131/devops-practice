# ALB — AWS Application Load Balancer Load Test

A shell script to stress-test an AWS Application Load Balancer and observe auto-scaling behaviour via CloudWatch.

## What it does

`load_test.sh` fires 200 concurrent HTTP requests at the ALB endpoint per datapoint, collects 15 datapoints one minute apart, and prints the requests-per-second rate for each. It also flags whether the RPS is above or below the configured auto-scaling threshold.

## Files

| File | Description |
|------|-------------|
| `load_test.sh` | Main load-test script |

## Configuration

Edit the variables at the top of `load_test.sh`:

```bash
LB_URL="http://<your-alb-dns>/"
THRESHOLD=37.5      # RPS threshold to watch
DATAPOINTS=15       # number of samples
INTERVAL=60         # seconds between samples
```

## Usage

```bash
chmod +x load_test.sh
./load_test.sh
```

After the run, open AWS CloudWatch → your ALB target group → **RequestCountPerTarget** to see the metric trend that triggered (or didn't trigger) auto-scaling.

## Prerequisites

- `curl` and `bc` installed on the machine running the script
- The ALB must be publicly reachable from that machine
