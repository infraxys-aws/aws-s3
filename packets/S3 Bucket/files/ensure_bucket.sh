#!/usr/bin/env bash

set -euo pipefail;

ensure_bucket_exists --bucket "$bucket_name" --region "$bucket_region";