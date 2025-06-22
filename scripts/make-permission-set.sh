#!/bin/bash

# Create Permission Set for FuelBidder tab visibility
# Run from anywhere in the git repository

echo "Creating FuelBidder Tabs Permission Set..."

REPO_ROOT="$(git rev-parse --show-toplevel)"

mkdir -p "${REPO_ROOT}/force-app/main/default/permissionsets"

cat > "${REPO_ROOT}/force-app/main/default/permissionsets/FuelBidder_Tabs.permissionset-meta.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<PermissionSet xmlns="http://soap.sforce.com/2006/04/metadata">
    <description>Grants access to FuelBidder custom object tabs</description>
    <label>FuelBidder Tabs</label>
    <tabSettings>
        <tab>Provider__c</tab>
        <visibility>Visible</visibility>
    </tabSettings>
    <tabSettings>
        <tab>Driver__c</tab>
        <visibility>Visible</visibility>
    </tabSettings>
    <tabSettings>
        <tab>Fuel_Order__c</tab>
        <visibility>Visible</visibility>
    </tabSettings>
</PermissionSet>
EOF

echo "✅ Permission Set created!"
echo ""
echo "Deploy with:"
echo "sf project deploy start --source-dir force-app/main/default/permissionsets"
echo ""
echo "After deployment, assign to your user:"
echo "Setup → Permission Sets → FuelBidder Tabs → Manage Assignments → Add Assignment"