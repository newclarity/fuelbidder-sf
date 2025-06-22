#!/bin/bash

# Create Fuel_Order_Item (1:1 with Standard OrderItem) and Fields
# Run from project root (fuelbidder/)

echo "Creating Fuel_Order_Item__c object (1:1 with Standard OrderItem)..."

# Create directories
mkdir -p force-app/main/default/objects/Fuel_Order_Item__c/fields

# Create main Fuel_Order_Item object
cat > force-app/main/default/objects/Fuel_Order_Item__c/Fuel_Order_Item__c.object-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">
    <actionOverrides>
        <actionName>Accept</actionName>
        <type>Default</type>
    </actionOverrides>
    <actionOverrides>
        <actionName>CancelEdit</actionName>
        <type>Default</type>
    </actionOverrides>
    <actionOverrides>
        <actionName>Clone</actionName>
        <type>Default</type>
    </actionOverrides>
    <actionOverrides>
        <actionName>Delete</actionName>
        <type>Default</type>
    </actionOverrides>
    <actionOverrides>
        <actionName>Edit</actionName>
        <type>Default</type>
    </actionOverrides>
    <actionOverrides>
        <actionName>List</actionName>
        <type>Default</type>
    </actionOverrides>
    <actionOverrides>
        <actionName>New</actionName>
        <type>Default</type>
    </actionOverrides>
    <actionOverrides>
        <actionName>SaveEdit</actionName>
        <type>Default</type>
    </actionOverrides>
    <actionOverrides>
        <actionName>Tab</actionName>
        <type>Default</type>
    </actionOverrides>
    <actionOverrides>
        <actionName>View</actionName>
        <type>Default</type>
    </actionOverrides>
    <allowInChatterGroups>false</allowInChatterGroups>
    <compactLayoutAssignment>SYSTEM</compactLayoutAssignment>
    <deploymentStatus>Deployed</deploymentStatus>
    <enableActivities>true</enableActivities>
    <enableBulkApi>true</enableBulkApi>
    <enableFeeds>false</enableFeeds>
    <enableHistory>true</enableHistory>
    <enableLicensing>false</enableLicensing>
    <enableReports>true</enableReports>
    <enableSearch>true</enableSearch>
    <enableSharing>true</enableSharing>
    <enableStreamingApi>true</enableStreamingApi>
    <label>Fuel Order Item</label>
    <nameField>
        <label>Fuel Order Item Name</label>
        <type>Text</type>
    </nameField>
    <pluralLabel>Fuel Order Items</pluralLabel>
    <searchLayouts/>
    <sharingModel>ReadWrite</sharingModel>
    <visibility>Public</visibility>
</CustomObject>
EOF

# OrderItem relationship field (1:1 with Standard OrderItem)
cat > force-app/main/default/objects/Fuel_Order_Item__c/fields/Order_Item__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Order_Item__c</fullName>
    <label>Order Item</label>
    <referenceTo>OrderItem</referenceTo>
    <relationshipLabel>Fuel Order Item Details</relationshipLabel>
    <relationshipName>Fuel_Order_Item_Details</relationshipName>
    <required>true</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Lookup</type>
    <deleteConstraint>Restrict</deleteConstraint>
</CustomField>
EOF

# Tank assignment
cat > force-app/main/default/objects/Fuel_Order_Item__c/fields/Target_Tank__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Target_Tank__c</fullName>
    <label>Target Tank</label>
    <referenceTo>Tank__c</referenceTo>
    <relationshipLabel>Fuel Order Items</relationshipLabel>
    <relationshipName>Fuel_Order_Items</relationshipName>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Lookup</type>
    <deleteConstraint>SetNull</deleteConstraint>
</CustomField>
EOF

# Tank meter reading before delivery
cat > force-app/main/default/objects/Fuel_Order_Item__c/fields/Pre_Delivery_Meter_Reading__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Pre_Delivery_Meter_Reading__c</fullName>
    <label>Pre-Delivery Meter Reading</label>
    <precision>8</precision>
    <required>false</required>
    <scale>1</scale>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Number</type>
    <unique>false</unique>
</CustomField>
EOF

# Tank meter reading after delivery
cat > force-app/main/default/objects/Fuel_Order_Item__c/fields/Post_Delivery_Meter_Reading__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Post_Delivery_Meter_Reading__c</fullName>
    <label>Post-Delivery Meter Reading</label>
    <precision>8</precision>
    <required>false</required>
    <scale>1</scale>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Number</type>
    <unique>false</unique>
</CustomField>
EOF

# Seal number start
cat > force-app/main/default/objects/Fuel_Order_Item__c/fields/Seal_Number_Start__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Seal_Number_Start__c</fullName>
    <label>Seal Number (Start)</label>
    <length>50</length>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Text</type>
    <unique>false</unique>
</CustomField>
EOF

# Seal number end
cat > force-app/main/default/objects/Fuel_Order_Item__c/fields/Seal_Number_End__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Seal_Number_End__c</fullName>
    <label>Seal Number (End)</label>
    <length>50</length>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Text</type>
    <unique>false</unique>
</CustomField>
EOF

# Tank access code for this delivery
cat > force-app/main/default/objects/Fuel_Order_Item__c/fields/Tank_Access_Code__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Tank_Access_Code__c</fullName>
    <label>Tank Access Code</label>
    <length>50</length>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Text</type>
    <unique>false</unique>
</CustomField>
EOF

# Delivery completion status
cat > force-app/main/default/objects/Fuel_Order_Item__c/fields/Delivery_Status__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Delivery_Status__c</fullName>
    <label>Delivery Status</label>
    <required>false</required>
    <trackHistory>true</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Picklist</type>
    <valueSet>
        <valueSetDefinition>
            <sorted>false</sorted>
            <value>
                <fullName>Pending</fullName>
                <default>true</default>
                <label>Pending</label>
            </value>
            <value>
                <fullName>In_Progress</fullName>
                <default>false</default>
                <label>In Progress</label>
            </value>
            <value>
                <fullName>Completed</fullName>
                <default>false</default>
                <label>Completed</label>
            </value>
            <value>
                <fullName>Failed</fullName>
                <default>false</default>
                <label>Failed</label>
            </value>
        </valueSetDefinition>
    </valueSet>
</CustomField>
EOF

# Delivery notes/exceptions
cat > force-app/main/default/objects/Fuel_Order_Item__c/fields/Delivery_Notes__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Delivery_Notes__c</fullName>
    <label>Delivery Notes</label>
    <length>32768</length>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>LongTextArea</type>
    <visibleLines>3</visibleLines>
</CustomField>
EOF

echo "Fuel_Order_Item__c object created successfully!"
echo "Run: sf project deploy start --source-dir force-app"