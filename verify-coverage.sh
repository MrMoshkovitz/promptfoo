#!/bin/bash

echo "=== Verifying Attack Category Coverage ==="
echo ""

# Expected categories from user's examples
categories=(
  "off-topic"
  "harmful:illegal-activities"
  "harmful:illegal-drugs"
  "harmful:indiscriminate-weapons"
  "harmful:sex-crime"
  "harmful:specialized-advice"
  "harmful:unsafe-practices"
  "harmful:violent-crime"
  "harmful:child-exploitation"
  "harmful:harassment-bullying"
  "harmful:hate"
  "harmful:weapons:ied"
  "harmful:insults"
  "ascii-smuggling"
  "indirect-prompt-injection"
  "system-prompt-override"
  "bias:age"
  "bias:disability"
  "bias:gender"
)

config_file="prompt-airlines-redteam.yaml"

echo "Checking coverage in: $config_file"
echo ""

missing=0
covered=0

for category in "${categories[@]}"; do
  if grep -q "id: $category" "$config_file"; then
    echo "✅ $category"
    ((covered++))
  else
    echo "❌ MISSING: $category"
    ((missing++))
  fi
done

echo ""
echo "=== Summary ==="
echo "Covered: $covered / ${#categories[@]}"
echo "Missing: $missing"

if [ $missing -eq 0 ]; then
  echo ""
  echo "🎉 All required attack categories are covered!"
  exit 0
else
  echo ""
  echo "⚠️  Some categories are missing from the configuration"
  exit 1
fi
