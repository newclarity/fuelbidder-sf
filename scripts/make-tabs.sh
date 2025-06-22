#!/bin/bash

# Create Working Custom Tabs for FuelBidder Objects
# Run from anywhere in the git repository

echo "Creating working custom tabs..."

REPO_ROOT="$(git rev-parse --show-toplevel)"

# Create tabs directory
mkdir -p "${REPO_ROOT}/force-app/main/default/tabs"

# Location tab
cat > "${REPO_ROOT}/force-app/main/default/tabs/Location__c.tab" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomTab xmlns="http://soap.sforce.com/2006/04/metadata">
    <customObject>true</customObject>
    <motif>Custom53: Bell</motif>
</CustomTab>
EOF

# Tank tab
cat > "${REPO_ROOT}/force-app/main/default/tabs/Tank__c.tab" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomTab xmlns="http://soap.sforce.com/2006/04/metadata">
    <customObject>true</customObject>
    <motif>Custom60: Fuel Gauge</motif>
</CustomTab>
EOF

# Provider tab
cat > "${REPO_ROOT}/force-app/main/default/tabs/Provider__c.tab" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomTab xmlns="http://soap.sforce.com/2006/04/metadata">
    <customObject>true</customObject>
    <motif>Custom37: Truck</motif>
</CustomTab>
EOF

# Driver tab
cat > "${REPO_ROOT}/force-app/main/default/tabs/Driver__c.tab" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomTab xmlns="http://soap.sforce.com/2006/04/metadata">
    <customObject>true</customObject>
    <motif>Custom98: Person</motif>
</CustomTab>
EOF

# Fuel Order tab
cat > "${REPO_ROOT}/force-app/main/default/tabs/Fuel_Order__c.tab" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomTab xmlns="http://soap.sforce.com/2006/04/metadata">
    <customObject>true</customObject>
    <motif>Custom45: Clipboard</motif>
</CustomTab>
EOF

# Fuel Order Item tab
cat > "${REPO_ROOT}/force-app/main/default/tabs/Fuel_Order_Item__c.tab" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomTab xmlns="http://soap.sforce.com/2006/04/metadata">
    <customObject>true</customObject>
    <motif>Custom41: List</motif>
</CustomTab>
EOF

echo "Working custom tabs created successfully!"
echo ""
echo "Tabs created:"
echo "- Locations"
echo "- Tanks"
echo "- Providers"
echo "- Drivers"
echo "- Fuel Orders"
echo "- Fuel Order Items"
echo ""
echo "Deploy with: sf project deploy start --source-dir force-app/main/default/tabs"
echo ""
echo "After deployment, tabs will appear in the App Launcher and can be added to your Sales app navigation!"