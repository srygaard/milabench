#!/usr/bin/env bash

set -euo pipefail

source .env

uv run pip install -e .[${MILABENCH_GPU_ARCH}]
uv run milabench install --select "${MILABENCH_SELECT_BENCH}"

if [[ "${MILABENCH_SELECT_BENCH}" != "dqn" ]]; then
  uv run milabench prepare --select "${MILABENCH_SELECT_BENCH}"
fi

uv run milabench run --select "${MILABENCH_SELECT_BENCH}"

#/tmp/milabench/base/venv/torch/bin/python benchmarks/purejaxrl/main.py dqn --num_envs 128 --buffer_size 131072 --buffer_batch_size 65536 --env_name SpaceInvaders-MinAtar --training_interval 10 --total_timesteps 2000000
# ${SCRATCH}/milabench/base/venv/torch/bin/python benchmarks/purejaxrl/main.py dqn --num_envs 128 --buffer_size 131072 --buffer_batch_size 65536 --env_name SpaceInvaders-MinAtar --training_interval 10 --total_timesteps 2000000
