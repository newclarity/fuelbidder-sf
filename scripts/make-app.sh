#!/bin/bash

# Create FuelBidder Custom App with all tabs
# Run from anywhere in the git repository

echo "Creating FuelBidder custom app..."

REPO_ROOT="$(git rev-parse --show-toplevel)"

# Create applications directory
mkdir -p "${REPO_ROOT}/force-app/main/default/applications"

# FuelBidder app
cat > "${REPO_ROOT}/force-app/main/default/applications/FuelBidder.app-meta.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomApplication xmlns="http://soap.sforce.com/2006/04/metadata">
    <brand>
        <headerColor>#0070D2</headerColor>
        <shouldOverrideOrgTheme>false</shouldOverrideOrgTheme>
    </brand>
    <description>FuelBidder - Fuel delivery marketplace application</description>
    <formFactors>Large</formFactors>
    <isNavAutoTempTabsDisabled>false</isNavAutoTempTabsDisabled>
    <isNavPersonalizationDisabled>false</isNavPersonalizationDisabled>
    <label>FuelBidder</label>
    <navType>Standard</navType>
    <tabs>standard-home</tabs>
    <tabs>standard-Account</tabs>
    <tabs>Location__c</tabs>
    <tabs>Tank__c</tabs>
    <tabs>Provider__c</tabs>
    <tabs>Driver__c</tabs>
    <tabs>Fuel_Order__c</tabs>
    <tabs>Fuel_Order_Item__c</tabs>
    <tabs>standard-report</tabs>
    <tabs>standard-Dashboard</tabs>
    <uiType>Lightning</uiType>
    <utilityBar>FuelBidder_UtilityBar</utilityBar>
</CustomApplication>
EOF

# Create a basic utility bar for the app
mkdir -p "${REPO_ROOT}/force-app/main/default/flexipages"

cat > "${REPO_ROOT}/force-app/main/default/flexipages/FuelBidder_UtilityBar.flexipage-meta.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<FlexiPage xmlns="http://soap.sforce.com/2006/04/metadata">
    <flexiPageRegions>
        <name>utilityItems</name>
        <type>Region</type>
    </flexiPageRegions>
    <masterLabel>FuelBidder Utility Bar</masterLabel>
    <template>
        <name>one:utilityBarTemplateDesktop</name>
        <properties>
            <name>isLeftAligned</name>
            <value>true</value>
        </properties>
    </template>
    <type>UtilityBar</type>
</FlexiPage>
EOF

echo "FuelBidder custom app created successfully!"
echo ""
echo "App includes:"
echo "- Home tab"
echo "- Accounts (standard)"
echo "- All FuelBidder custom object tabs:"
echo "  * Locations"
echo "  * Tanks"
echo "  * Providers"
echo "  * Drivers"
echo "  * Fuel Orders"
echo "  * Fuel Order Items"
echo "- Chatter, Reports, Dashboards"
echo ""
echo "Deploy with: sf project deploy start --source-dir force-app/main/default/applications force-app/main/default/flexipages"
echo ""
echo "After deployment:"
echo "1. Switch to 'FuelBidder' app using the App Launcher (9 dots)"
echo "2. All your custom tabs will be available in the navigation!"
echo "3. Set as default app: Setup → App Manager → FuelBidder → Edit → Make default for your profile"