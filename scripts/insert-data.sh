#!/usr/bin/env bash

APEX_FILE="$1"
REPO_ROOT="$(git rev-parse --show-toplevel)"
sf apex run --file "${REPO_ROOT}/scripts/apex/${APEX_FILE}"

