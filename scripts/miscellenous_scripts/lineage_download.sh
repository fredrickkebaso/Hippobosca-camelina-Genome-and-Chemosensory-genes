#!/bin/bash

# Function to check if a lineage dataset exists
check_lineage_exists() {
  local lineage=$1
  if [ -d "$databases/$lineage" ]; then
    return 0
  else
    return 1
  fi
}

# Main script
if [ ! -d "$databases" ]; then
  # Create directory if it doesn't exist
  mkdir -p "$databases"
  echo "Downloading ${lineages[@]} datasets"
  compleasm download lineages ${lineages[@]} ${threads} --library_path ${databases}
  echo "Downloading databases done."
else
  # Check for each lineage if it exists
  missing_lineages=()
  for lineage in "${lineages[@]}"; do
    if ! check_lineage_exists "$lineage"; then
      missing_lineages+=("$lineage")
    fi
  done

  # Download missing lineages if any
  if [ ${#missing_lineages[@]} -gt 0 ]; then
    echo "Downloading missing datasets: ${missing_lineages[@]}"
    compleasm download lineages ${missing_lineages[@]} ${threads} --library_path ${databases}
    echo "Downloading missing databases done."
  else
    echo "All specified lineages already exist in the database."
  fi
fi
