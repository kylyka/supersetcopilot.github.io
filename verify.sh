#!/bin/bash

# Superset Copilot Website Verification Script
# This script verifies the website setup according to requirements

echo "==================================================="
echo "Superset Copilot Website Verification"
echo "==================================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check 1: CNAME file
echo "1. Checking CNAME file..."
if [ -f "CNAME" ]; then
    CNAME_CONTENT=$(cat CNAME | tr -d '\n\r ')
    if [ "$CNAME_CONTENT" = "supersetcopilot.eu" ]; then
        echo -e "${GREEN}✓${NC} CNAME file exists with correct value: supersetcopilot.eu"
    else
        echo -e "${RED}✗${NC} CNAME file has incorrect value: $CNAME_CONTENT"
        exit 1
    fi
else
    echo -e "${RED}✗${NC} CNAME file does not exist"
    exit 1
fi
echo ""

# Check 2: index.html file
echo "2. Checking index.html file..."
if [ -f "index.html" ]; then
    if grep -q "Superset Copilot – aktivní" index.html; then
        echo -e "${GREEN}✓${NC} index.html contains required text: 'Superset Copilot – aktivní'"
    else
        echo -e "${RED}✗${NC} index.html does not contain required text"
        exit 1
    fi
else
    echo -e "${RED}✗${NC} index.html does not exist"
    exit 1
fi
echo ""

# Check 3: DNS A records
echo "3. Checking DNS A records for supersetcopilot.eu..."
DNS_RESULT=$(dig supersetcopilot.eu A +short 2>/dev/null | sort)
EXPECTED_IPS="185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153"

if [ -z "$DNS_RESULT" ]; then
    echo -e "${YELLOW}⚠${NC} DNS not configured yet (no A records found)"
    echo "   Expected A records:"
    echo "   - 185.199.108.153"
    echo "   - 185.199.109.153"
    echo "   - 185.199.110.153"
    echo "   - 185.199.111.153"
else
    if [ "$DNS_RESULT" = "$(echo "$EXPECTED_IPS" | sort)" ]; then
        echo -e "${GREEN}✓${NC} DNS A records configured correctly"
    else
        echo -e "${YELLOW}⚠${NC} DNS A records found but may not match expected values"
        echo "   Found:"
        echo "$DNS_RESULT" | sed 's/^/   - /'
        echo "   Expected:"
        echo "$EXPECTED_IPS" | sed 's/^/   - /'
    fi
fi
echo ""

# Check 4: Website accessibility
echo "4. Checking website accessibility..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://supersetcopilot.eu 2>/dev/null)

if [ "$HTTP_CODE" = "200" ]; then
    echo -e "${GREEN}✓${NC} Website is accessible (HTTP 200)"
    
    # Check 5: Content verification
    echo ""
    echo "5. Verifying website content..."
    CONTENT=$(curl -s https://supersetcopilot.eu 2>/dev/null)
    
    if echo "$CONTENT" | grep -q "Superset Copilot – aktivní"; then
        echo -e "${GREEN}✓${NC} Website contains required text: 'Superset Copilot – aktivní'"
        echo ""
        echo "==================================================="
        echo -e "${GREEN}✓ Web je funkční.${NC}"
        echo "==================================================="
    else
        echo -e "${RED}✗${NC} Website does not contain required text"
        exit 1
    fi
elif [ "$HTTP_CODE" = "000" ]; then
    echo -e "${YELLOW}⚠${NC} Website not accessible (connection failed)"
    echo "   This is expected if DNS is not configured yet"
else
    echo -e "${YELLOW}⚠${NC} Website returned HTTP $HTTP_CODE"
fi
echo ""

# Summary
echo "==================================================="
echo "Summary of Remaining Tasks:"
echo "==================================================="
echo ""

# Check if DNS is configured
if [ -z "$DNS_RESULT" ]; then
    echo "❌ DNS Configuration Required:"
    echo "   Configure A records for supersetcopilot.eu:"
    echo "   - 185.199.108.153"
    echo "   - 185.199.109.153"
    echo "   - 185.199.110.153"
    echo "   - 185.199.111.153"
    echo ""
fi

# Check if website is accessible
if [ "$HTTP_CODE" != "200" ]; then
    echo "❌ GitHub Pages Configuration:"
    echo "   1. Merge this PR to main branch"
    echo "   2. Go to Settings → Pages"
    echo "   3. Set Source: Deploy from branch"
    echo "   4. Set Branch: main, Folder: / (root)"
    echo "   5. Set Custom domain: supersetcopilot.eu"
    echo "   6. Enable 'Enforce HTTPS'"
    echo ""
fi

if [ "$HTTP_CODE" = "200" ] && [ -n "$DNS_RESULT" ]; then
    echo "✅ All checks passed! Website is fully functional."
fi

echo ""
echo "For detailed setup instructions, see SETUP.md"
echo "==================================================="
