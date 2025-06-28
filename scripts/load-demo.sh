#!/bin/bash

# FuelBidder Demo Data Loader
# Loads demo data with proper error handling and logging

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Configuration
ORG_ALIAS="${1:-fuelbidder-dev}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="$SCRIPT_DIR/demo-data"
LOG_DIR="$SCRIPT_DIR/logs"
LOG_FILE="$LOG_DIR/demo-data-$(date +%Y%m%d-%H%M%S).log"

# Colors for log_file
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create logs directory if it doesn't exist
mkdir -p "$LOG_DIR"

echo_msg() {
  local msg="$1"
  if [ "${msg}" == "" ]; then 
    return 
  fi
  echo -e "${msg}${NC}"
}
echo_file() {
  local file="$1"
  cat "${file}"
  echo
}
log_msg() {
  local msg="$1"
  if [ "${msg}" == "" ]; then 
    return 
  fi
  {
    echo "${msg}"
    echo
  } >> "${LOG_FILE}"
}
log_file() {
  echo_file "$1" >> "${LOG_FILE}"
}
show_log_filename() {
  if [ $? -ne 0 ]; then
    echo_msg "${YELLOW}Full log available at: ${LOG_FILE}"
  fi
}
trap show_log_filename EXIT

# Initialize log file
log_msg "FuelBidder Demo Data Load - $(date)
Target Org: $ORG_ALIAS
========================================"

# Run apex script
run_apex_script_raw() {
  local script_file="$1"
  sf apex run --file "${DEMO_DIR}/${script_file}" --target-org "${ORG_ALIAS}" > "${log_file}" 2>&1
}

# Run apex script with error handling
run_apex_script() {
    local step_num="$1"
    local step_name="$2"
    local script_file="$3"
    local log_file

    echo -e "${BLUE}Step ${step_num}: ${step_name}..."
    log_msg "Step ${step_num}: ${step_name} - $(date)"

    # Create temp file for command log_file
    log_file=$(mktemp)

    # Run the command, capture both stdout and stderr
    if run_apex_script_raw "${script_file}"; then
        # Success - log log_file but don't display
        log_msg "✅ SUCCESS"
        echo_msg "${GREEN}✅ ${step_name} completed"
    else
        log_msg "❌ ERROR"
        log_file "${log_file}"
        echo_msg "❌ Error in ${step_name}"

        # Cleanup and exit
        rm -f "${log_file}"
        exit 1
    fi

    # Cleanup temp file
    rm -f "${log_file}"
}

# Check the Salesforce org exists
check_org_raw() {
  local local_log="$1"
  sf org display --target-org "${ORG_ALIAS}" > "${local_log}" 2>&1
}

# Check the Salesforce org exists with error handling
check_org() {
    local log_file
    local_log=$(mktemp)

    echo_msg "${BLUE}🔍 Checking org status..."
    log_msg "Checking org status - $(date)"

    if ! check_org_raw "${local_log}"; then
        log_msg "❌ Org access failed"
        log_file "${local_log}" >> "${LOG_FILE}"

        echo_msg "${RED}❌ Cannot access org: $ORG_ALIAS\n${YELLOW}Command output:"
        echo_file "${local_log}"
        echo_msg "${YELLOW}Make sure the org exists and you're authenticated"

        rm -f "${local_log}"
        exit 1
    fi
    log_msg "✅ Org status OK"
    log_file "${local_log}"
    echo_msg "${GREEN}✅ Org $ORG_ALIAS is accessible"
    rm -f "${log_file}"
}

# Function to check if a single script exists and is readable
check_script() {
    local script_file="$1"
    local script_path="${DEMO_DIR}/${script_file}"

    if [[ ! -f "${script_path}" ]]; then
        log_msg "❌ Missing script: ${script_file}"
        echo_msg "${RED}❌ Missing script: ${script_file}"
        return 1
    fi

    if [[ ! -r "${script_path}" ]]; then
        log_msg "❌ Cannot read script: ${script_file}"
        echo_msg "${RED}❌ Cannot read script: ${script_file}"
        return 1
    fi

    log_msg "✅ Found: ${script_file}"
    return 0
}

# Function to discover and check demo data scripts
check_scripts() {
    echo_msg "${BLUE}📁 Checking demo data scripts..."
    log_msg "Checking demo data scripts - $(date)"

    # Check if demo directory exists
    if [[ ! -d "${DEMO_DIR}" ]]; then
        log_msg "❌ Demo data directory not found: ${DEMO_DIR}"
        echo_msg "${RED}❌ Demo data directory not found: ${DEMO_DIR}"
        exit 1
    fi

    # Discover all .apex files in demo directory, sorted by filename
    local script_files=()
    while IFS= read -r -d '' file; do
        script_files+=("$(basename "$file")")
    done < <(find "${DEMO_DIR}" -name "*.apex" -type f -print0 | sort -z)

    # Check if we found any scripts
    if [[ ${#script_files[@]} -eq 0 ]]; then
        log_msg "❌ No .apex scripts found in ${DEMO_DIR}"
        echo_msg "${RED}❌ No .apex scripts found in: ${DEMO_DIR}"
        exit 1
    fi

    log_msg "Found ${#script_files[@]} demo scripts:"
    echo_msg "${BLUE}Found ${#script_files[@]} demo scripts:"

    # Check each script individually
    local failed_scripts=()
    local script_count=0

    for script in "${script_files[@]}"; do
        ((script_count++))
        echo_msg "${BLUE}  $script_count. $script"

        if ! check_script "$script"; then
            failed_scripts+=("$script")
        fi
    done

    # Report results
    if [[ ${#failed_scripts[@]} -gt 0 ]]; then
        log_msg "❌ Failed script checks: ${failed_scripts[*]}"
        echo_msg "${RED}❌ Script validation failed\n${YELLOW}Expected location: ${DEMO_DIR}"
        exit 1
    else
        log_msg "✅ All scripts validated successfully"
        echo_msg "${GREEN}✅ All demo data scripts validated"
    fi

    log_msg "" 

    # Store discovered scripts for execution
    DEMO_SCRIPTS=("${script_files[@]}")
}

# Function to execute all discovered demo scripts
execute_demo_scripts() {
    local step_num=0

    echo_msg "${BLUE}🔄 Loading demo data..."
    for script in "${DEMO_SCRIPTS[@]}"; do
        # Extract step name from filename (remove number prefix and .apex extension)
        local step_name
        step_name=$(echo "$script" | sed 's/^[0-9]*-//' | sed 's/\.apex$//' | tr '-' ' ' | sed 's/\b\w/\U&/g')

        run_apex_script "${step_num}" "${step_name}" "$script"
        ((step_num++))
    done
}

# Main execution
main() {
  echo_msg "${BLUE}🚀 FuelBidder Demo Data Loader
${BLUE}Target Org: $ORG_ALIAS
${BLUE}Log File: ${LOG_FILE}"
  echo ""

  # Pre-flight checks
  check_org
  check_scripts

  # Execute demo data scripts
  execute_demo_scripts

  # Success summary
  echo ""
  echo_msg "${GREEN}🎉 Demo data loading complete!
${BLUE}Executed ${#DEMO_SCRIPTS[@]} scripts successfully"

  # Log final success
  log_msg "\n========================================
Demo data loading completed successfully - $(date)
Scripts executed: ${#DEMO_SCRIPTS[@]}"
  for script in "${DEMO_SCRIPTS[@]}"; do
    log_msg "  - $script"
  done
}

# Show usage if help requested
if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
  # shellcheck disable=SC1073
  cat <<- EOF
    Usage: $0 [ORG_ALIAS]

    Loads FuelBidder demo data into specified Salesforce org

    Arguments:
      ORG_ALIAS    Salesforce org alias (default: fuelbidder-dev)

    Examples:
      $0                    # Load into fuelbidder-dev
      $0 fuelbidder-test    # Load into fuelbidder-test

    The script automatically discovers and executes all .apex files in
    scripts/demo-data/ directory, sorted by filename.

    Logs are written to: logs/demo-data-YYYYMMDD-HHMMSS.log
EOF
  exit 0
fi

# Run main function
main "$@"

