#!/bin/bash

# Add tab visibility for FuelBidder custom objects to Admin profile
# Run from anywhere in the git repository

echo "Adding tab visibility to Admin profile..."

REPO_ROOT="$(git rev-parse --show-toplevel)"
PROFILE_FILE="${REPO_ROOT}/force-app/main/default/profiles/Admin.profile-meta.xml"

# Backup the original profile
cp "$PROFILE_FILE" "${PROFILE_FILE}.backup"

# Validate XML first
if ! xmllint --noout "$PROFILE_FILE" 2>/dev/null; then
    echo "❌ Invalid XML in profile file"
    exit 1
fi

# Custom tabs to add
TABS=("Location__c" "Tank__c" "Provider__c" "Driver__c" "Fuel_Order__c" "Fuel_Order_Item__c")

echo "Adding tab visibility for custom objects..."

# Create temporary file with tab visibility blocks
TEMP_FILE=$(mktemp)

# Copy everything except the closing </Profile> tag
sed '/<\/Profile>/d' "$PROFILE_FILE" > "$TEMP_FILE"

# Add tab visibility blocks
for tab in "${TABS[@]}"; do
    cat >> "$TEMP_FILE" << EOF
    <tabVisibilities>
        <tab>$tab</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
EOF
    echo "Added tab visibility: $tab"
done

# Add closing tag
echo "</Profile>" >> "$TEMP_FILE"

# Validate the new XML
if xmllint --noout "$TEMP_FILE" 2>/dev/null; then
    mv "$TEMP_FILE" "$PROFILE_FILE"
    echo "✅ Profile XML updated and validated"
else
    echo "❌ Generated invalid XML, restoring backup"
    mv "${PROFILE_FILE}.backup" "$PROFILE_FILE"
    rm -f "$TEMP_FILE"
    exit 1
fi

echo ""
echo "Deploying updated Admin profile..."

# Deploy the updated profile
sf project deploy start --source-dir force-app/main/default/profiles

echo ""
echo "✅ Tab visibility deployment complete!"
echo ""
echo "Your custom tabs should now be visible in the FuelBidder app."
echo "Refresh your browser to see the changes."
echo ""
echo "If you need to restore the original profile:"
echo "cp ${PROFILE_FILE}.backup ${PROFILE_FILE}"