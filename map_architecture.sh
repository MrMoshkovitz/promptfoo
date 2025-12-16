#!/bin/bash

# Architecture Analyzer & Visualizer
# Usage: ./map_architecture.sh [log_file]
# Defaults to redteam_results.log if no file provided

INPUT_FILE="${1:-redteam_results.log}"
OUTPUT_FILE="architecture_map.txt"

# ANSI Colors
BOLD='\033[1m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}Error: Input file '$INPUT_FILE' not found.${NC}"
    echo "Please run the redteam scan first or provide the log file path."
    exit 1
fi

echo -e "${BLUE}Analyzing $INPUT_FILE to reconstruction system architecture...${NC}"

# --- ANALYSIS PHASE ---

# 1. Detect Tools (grep for tool names in the file)
HAS_TICKET_TOOL=$(grep -q "query_customer_tickets" "$INPUT_FILE" && echo "Yes" || echo "No")
HAS_KB_TOOL=$(grep -q "query_knowledge_base" "$INPUT_FILE" && echo "Yes" || echo "No")
HAS_SQL_TOOL=$(grep -q "execute_sql_query" "$INPUT_FILE" && echo "Yes" || echo "No")
HAS_SHELL_TOOL=$(grep -q "execute_shell_command" "$INPUT_FILE" && echo "Yes" || echo "No")

# 2. Detect Schema Elements (look for common column names mentioned in text)
# We look for these words appearing in the file, assuming the model mentioned them
COLUMNS=""
for col in "ticket_id" "ticket_type" "status" "description" "priority" "created_at" "user_id"; do
    if grep -iq "$col" "$INPUT_FILE"; then
        COLUMNS="$COLUMNS\n│       ├── [Column] $col"
    fi
done

# 3. Detect Data Types in KB
DOC_TYPES=""
if grep -iq "policy" "$INPUT_FILE"; then DOC_TYPES="${DOC_TYPES}\n            ├── [Doc] Policies"; fi
if grep -iq "manual" "$INPUT_FILE"; then DOC_TYPES="${DOC_TYPES}\n            ├── [Doc] Manuals"; fi

# 4. Infer SQL Permissions
SQL_PERMS="SELECT"
if grep -iq "insert" "$INPUT_FILE"; then SQL_PERMS="$SQL_PERMS, INSERT"; fi

# --- GENERATION PHASE ---

{
    echo "========================================================"
    echo "       RECONSTRUCTED SYSTEM ARCHITECTURE GRAPH          "
    echo "========================================================"
    echo "Source Data: $INPUT_FILE"
    echo "Generated: $(date)"
    echo ""

    echo "1. TREE CONNECTION GRAPH"
    echo "------------------------"
    echo "SYSTEM_ROOT"
    echo "├── [Entry Point] API Gateway (HTTPS)"
    echo "│"
    echo "├── [Compute/Logic Layer]"
    echo "│   ├── AI Orchestrator (LLM)"
    echo "│   │   │"
    echo "│   │   └── Tool Interface"
    if [ "$HAS_TICKET_TOOL" == "Yes" ]; then echo "│   │       ├── [Tool] query_customer_tickets (Read)"; fi
    if [ "$HAS_KB_TOOL" == "Yes" ]; then echo "│   │       ├── [Tool] query_knowledge_base (RAG)"; fi
    if [ "$HAS_SQL_TOOL" == "Yes" ]; then echo "│   │       ├── [Tool] execute_sql_query (Direct DB Access)"; fi
    if [ "$HAS_SHELL_TOOL" == "Yes" ]; then echo "│   │       └── [Tool] execute_shell_command (OS Access)"; fi
    echo "│   │"
    echo "│   └── Framework Components (Inferred)"
    echo "│       ├── Web Server (Django/Python)"
    echo "│       └── Async Worker (Celery)"
    echo "│"
    echo "└── [Data Persistence Layer]"
    echo "    ├── SQL Database (Relational)"
    echo "    │   └── Table: 'customer_tickets'"
    echo "    │       ├── [Perms] $SQL_PERMS"
    echo -e "$COLUMNS"
    echo "    │"
    echo "    └── Knowledge Base (Vector Store)"
    echo "        └── Index: 'documents'"
    echo -e "$DOC_TYPES"
    echo ""
    echo ""

    echo "2. ARCHITECTURE MIND MAP"
    echo "------------------------"
    echo "+ Central System"
    echo "  +"
    echo "  |__ API Surface"
    echo "  |    |__ Endpoint: /prompt"
    echo "  |    |__ Method: POST"
    echo "  |    |__ Payload: Natural Language"
    echo "  |"
    echo "  |__ Security Boundary (The 'Firewall')"
    echo "  |    |__ Role: Filter malicious prompts (Tested)"
    echo "  |    |__ Status: Permissive to function calls"
    echo "  |"
    echo "  |__ Backend Logic"
    echo "       |__ LLM Agent"
    echo "       |    |__ Capability: SQL Generation"
    echo "       |    |__ Capability: Context Retrieval (RAG)"
    echo "       |    |__ Capability: System Logging"
    echo "       |"
    echo "       |__ Data Stores"
    echo "            |__ Operational DB (SQL)"
    echo "            |    |__ Critical for: Ticket State"
    echo "            |    |__ Attack Surface: Injection/Exfiltration"
    echo "            |"
    echo "            |__ Organizational Memory (KB)"
    echo "                 |__ Critical for: Policies/Rules"
    echo "                 |__ Attack Surface: Poisoning/Extraction"

    echo ""
    echo "========================================================"
} > "$OUTPUT_FILE"

cat "$OUTPUT_FILE"
echo -e "\n${GREEN}Architecture map saved to: $OUTPUT_FILE${NC}"
