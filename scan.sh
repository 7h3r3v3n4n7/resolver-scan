#!/bin/bash

INPUT="targets.txt"
RESOLVED="resolved.txt"
OUTPUT_PREFIX="stealth_scan"

# Clear any existing resolved list
> "$RESOLVED"

echo "[*] Resolving domains from '$INPUT'..."

while read -r domain; do
    ip=$(dig +short "$domain" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1)
    if [[ -n "$ip" ]]; then
        echo "$ip" >> "$RESOLVED"
        echo "  - $domain => $ip"
    else
        echo "  - $domain => [UNRESOLVED]"
    fi
done < "$INPUT"

# Deduplicate IPs
sort -u "$RESOLVED" -o "$RESOLVED"

IP_COUNT=$(wc -l < "$RESOLVED")
echo "[*] Starting stealth scan on $IP_COUNT IPs..."

nmap -Pn -n -sS -sU \
     -sV --script=default \
     -T2 \
     --randomize-hosts \
     --defeat-rst-ratelimit \
     -iL "$RESOLVED" \
     -oA "$OUTPUT_PREFIX"

echo "[*] Scan complete."
echo "    - Normal output:    ${OUTPUT_PREFIX}.nmap"
echo "    - Grepable output:  ${OUTPUT_PREFIX}.gnmap"
echo "    - XML output:       ${OUTPUT_PREFIX}.xml"
