#!/bin/bash

# Create Fuel_Order (1:1 with Standard Order) and Fields
# Run from project root (fuelbidder/)

echo "Creating Fuel_Order__c object (1:1 with Standard Order)..."

# Create directories
mkdir -p force-app/main/default/objects/Fuel_Order__c/fields

# Create main Fuel_Order object
cat > force-app/main/default/objects/Fuel_Order__c/Fuel_Order__c.object-meta.xml << 'EOF'
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
    <label>Fuel Order</label>
    <nameField>
        <label>Fuel Order Name</label>
        <type>Text</type>
    </nameField>
    <pluralLabel>Fuel Orders</pluralLabel>
    <searchLayouts/>
    <sharingModel>ControlledByParent</sharingModel>
    <visibility>Public</visibility>
</CustomObject>
EOF

# Order relationship field (1:1 with Standard Order)
cat > force-app/main/default/objects/Fuel_Order__c/fields/Order__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Order__c</fullName>
    <label>Order</label>
    <referenceTo>Order</referenceTo>
    <relationshipLabel>Fuel Order Details</relationshipLabel>
    <relationshipName>Fuel_Order_Details</relationshipName>
    <relationshipOrder>0</relationshipOrder>
    <reparentableMasterDetail>false</reparentableMasterDetail>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>MasterDetail</type>
    <writeRequiresMasterRead>false</writeRequiresMasterRead>
</CustomField>
EOF

# Provider Account assignment
cat > force-app/main/default/objects/Fuel_Order__c/fields/Assigned_Provider__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Assigned_Provider__c</fullName>
    <label>Assigned Provider</label>
    <referenceTo>Account</referenceTo>
    <relationshipLabel>Assigned Fuel Orders</relationshipLabel>
    <relationshipName>Assigned_Fuel_Orders</relationshipName>
    <required>false</required>
    <trackHistory>true</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Lookup</type>
    <deleteConstraint>SetNull</deleteConstraint>
</CustomField>
EOF

# Driver Contact assignment
cat > force-app/main/default/objects/Fuel_Order__c/fields/Assigned_Driver__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Assigned_Driver__c</fullName>
    <label>Assigned Driver</label>
    <referenceTo>Contact</referenceTo>
    <relationshipLabel>Assigned Fuel Orders</relationshipLabel>
    <relationshipName>Assigned_Fuel_Orders</relationshipName>
    <required>false</required>
    <trackHistory>true</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Lookup</type>
    <deleteConstraint>SetNull</deleteConstraint>
</CustomField>
EOF

# IoT Trigger flag
cat > force-app/main/default/objects/Fuel_Order__c/fields/IoT_Triggered_Order__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>IoT_Triggered_Order__c</fullName>
    <label>IoT Triggered Order</label>
    <defaultValue>false</defaultValue>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Checkbox</type>
</CustomField>
EOF

# Delivery Instructions
cat > force-app/main/default/objects/Fuel_Order__c/fields/Delivery_Instructions__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Delivery_Instructions__c</fullName>
    <label>Delivery Instructions</label>
    <length>32768</length>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>LongTextArea</type>
    <visibleLines>3</visibleLines>
</CustomField>
EOF

# Delivery Window Start
cat > force-app/main/default/objects/Fuel_Order__c/fields/Delivery_Window_Start__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Delivery_Window_Start__c</fullName>
    <label>Delivery Window Start</label>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>DateTime</type>
</CustomField>
EOF

# Delivery Window End
cat > force-app/main/default/objects/Fuel_Order__c/fields/Delivery_Window_End__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Delivery_Window_End__c</fullName>
    <label>Delivery Window End</label>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>DateTime</type>
</CustomField>
EOF

# GPS Coordinates
cat > force-app/main/default/objects/Fuel_Order__c/fields/Delivery_GPS_Coordinates__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Delivery_GPS_Coordinates__c</fullName>
    <label>Delivery GPS Coordinates</label>
    <displayLocationInDecimal>true</displayLocationInDecimal>
    <required>false</required>
    <scale>6</scale>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Location</type>
</CustomField>
EOF

# Emergency Contact
cat > force-app/main/default/objects/Fuel_Order__c/fields/Emergency_Contact_Phone__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Emergency_Contact_Phone__c</fullName>
    <label>Emergency Contact Phone</label>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Phone</type>
</CustomField>
EOF

echo "Fuel_Order__c object created successfully!"
echo "Run: sf project deploy start --source-dir force-app"