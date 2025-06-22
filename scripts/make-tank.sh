#!/bin/bash

# Create Tank Object and Fields
# Run from project root (fuelbidder/)

echo "Creating Tank__c object and fields..."

# Create directories
mkdir -p force-app/main/default/objects/Tank__c/fields

# Create main Tank object
cat > force-app/main/default/objects/Tank__c/Tank__c.object-meta.xml << 'EOF'
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
    <label>Tank</label>
    <nameField>
        <label>Tank Name</label>
        <type>Text</type>
    </nameField>
    <pluralLabel>Tanks</pluralLabel>
    <searchLayouts/>
    <sharingModel>ControlledByParent</sharingModel>
    <visibility>Public</visibility>
</CustomObject>
EOF

# Location relationship field
cat > force-app/main/default/objects/Tank__c/fields/Location__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Location__c</fullName>
    <label>Location</label>
    <referenceTo>Location__c</referenceTo>
    <relationshipLabel>Tanks</relationshipLabel>
    <relationshipName>Tanks</relationshipName>
    <relationshipOrder>0</relationshipOrder>
    <reparentableMasterDetail>false</reparentableMasterDetail>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>MasterDetail</type>
    <writeRequiresMasterRead>false</writeRequiresMasterRead>
</CustomField>
EOF

# Fuel Type field
cat > force-app/main/default/objects/Tank__c/fields/Fuel_Type__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Fuel_Type__c</fullName>
    <label>Fuel Type</label>
    <required>true</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Picklist</type>
    <valueSet>
        <valueSetDefinition>
            <sorted>false</sorted>
            <value>
                <fullName>Diesel</fullName>
                <default>true</default>
                <label>Diesel</label>
            </value>
            <value>
                <fullName>Heating_Oil</fullName>
                <default>false</default>
                <label>Heating Oil</label>
            </value>
            <value>
                <fullName>Gasoline</fullName>
                <default>false</default>
                <label>Gasoline</label>
            </value>
            <value>
                <fullName>Kerosene</fullName>
                <default>false</default>
                <label>Kerosene</label>
            </value>
        </valueSetDefinition>
    </valueSet>
</CustomField>
EOF

# Capacity field
cat > force-app/main/default/objects/Tank__c/fields/Capacity_Gallons__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Capacity_Gallons__c</fullName>
    <label>Tank Capacity (Gallons)</label>
    <precision>8</precision>
    <required>true</required>
    <scale>0</scale>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Number</type>
    <unique>false</unique>
</CustomField>
EOF

# Current Level field
cat > force-app/main/default/objects/Tank__c/fields/Current_Level_Gallons__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Current_Level_Gallons__c</fullName>
    <label>Current Level (Gallons)</label>
    <precision>8</precision>
    <required>false</required>
    <scale>1</scale>
    <trackHistory>true</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Number</type>
    <unique>false</unique>
</CustomField>
EOF

# Low Level Threshold field
cat > force-app/main/default/objects/Tank__c/fields/Low_Level_Threshold__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Low_Level_Threshold__c</fullName>
    <label>Low Level Threshold (Gallons)</label>
    <precision>8</precision>
    <required>false</required>
    <scale>0</scale>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Number</type>
    <unique>false</unique>
</CustomField>
EOF

# Has IoT Device field
cat > force-app/main/default/objects/Tank__c/fields/Has_IoT_Device__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Has_IoT_Device__c</fullName>
    <label>Has IoT Device</label>
    <defaultValue>false</defaultValue>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Checkbox</type>
</CustomField>
EOF

# IoT Device ID field
cat > force-app/main/default/objects/Tank__c/fields/IoT_Device_ID__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>IoT_Device_ID__c</fullName>
    <label>IoT Device ID</label>
    <length>50</length>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Text</type>
    <unique>true</unique>
</CustomField>
EOF

# Last IoT Reading field
cat > force-app/main/default/objects/Tank__c/fields/Last_IoT_Reading__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Last_IoT_Reading__c</fullName>
    <label>Last IoT Reading</label>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>DateTime</type>
</CustomField>
EOF

# Tank Is Locked field
cat > force-app/main/default/objects/Tank__c/fields/Tank_Is_Locked__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Tank_Is_Locked__c</fullName>
    <label>Tank Is Locked</label>
    <defaultValue>false</defaultValue>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Checkbox</type>
</CustomField>
EOF

# Tank Access Hours field
cat > force-app/main/default/objects/Tank__c/fields/Tank_Access_Hours__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Tank_Access_Hours__c</fullName>
    <label>Tank Access Hours</label>
    <length>100</length>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Text</type>
    <unique>false</unique>
</CustomField>
EOF

# Tank Access Instructions field
cat > force-app/main/default/objects/Tank__c/fields/Tank_Access_Instructions__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Tank_Access_Instructions__c</fullName>
    <label>Tank Access Instructions</label>
    <length>32768</length>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>LongTextArea</type>
    <visibleLines>3</visibleLines>
</CustomField>
EOF

# Active Tank field
cat > force-app/main/default/objects/Tank__c/fields/Active_Tank__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Active_Tank__c</fullName>
    <label>Active Tank</label>
    <defaultValue>true</defaultValue>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Checkbox</type>
</CustomField>
EOF

echo "Tank__c object and fields created successfully!"
echo "Run: sf project deploy start --source-dir force-app"