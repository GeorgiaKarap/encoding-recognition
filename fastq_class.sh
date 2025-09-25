#!/bin/bash

mkdir -p phred33 phred64

for file in *.fastq; do
  echo "Processing $file"

  quality=""
  found_plus=0

  while IFS= read -r line; do
    if [[ $found_plus -eq 1 ]]; then
      quality+="$line"
      found_plus=0
    elif [[ $line == "+"* ]]; then
      found_plus=1
    fi
  done < "$file"

  if [ -z "$quality" ]; then
    echo "No quality scores found"
    continue
  fi

  ascii=$(echo -n "$quality" | od -An -t u1)

  min=$(echo "$ascii" | tr ' ' '\n' | grep -E '^[0-9]+$' | sort -n | head -n1)
  max=$(echo "$ascii" | tr ' ' '\n' | grep -E '^[0-9]+$' | sort -n | tail -n1)

  echo "  Min ASCII: $min"
  echo "  Max ASCII: $max"

  if [ "$min" -ge 33 ] && [ "$max" -le 74 ]; then
    mv "$file" phred33/
    echo "Classified as phred33"
  elif [ "$min" -ge 64 ] && [ "$max" -le 104 ]; then
    mv "$file" phred64/
    echo "Classified as phred64"
  else
    echo "Could not classify $file"
  fi
done
