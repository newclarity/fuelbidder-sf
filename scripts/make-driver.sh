#!/bin/bash

# Create Driver Object and Fields
# Run from project root (fuelbidder/)

echo "Creating Driver__c object and fields..."

# Create directories
mkdir -p force-app/main/default/objects/Driver__c/fields

# Create main Driver object
cat > force-app/main/default/objects/Driver__c/Driver__c.object-meta.xml << 'EOF'
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
    <label>Driver</label>
    <nameField>
        <label>Driver Name</label>
        <type>Text</type>
    </nameField>
    <pluralLabel>Drivers</pluralLabel>
    <searchLayouts/>
    <sharingModel>ControlledByParent</sharingModel>
    <visibility>Public</visibility>
</CustomObject>
EOF

# Contact relationship field (1:1 with Contact)
cat > force-app/main/default/objects/Driver__c/fields/Contact__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Contact__c</fullName>
    <label>Contact</label>
    <referenceTo>Contact</referenceTo>
    <relationshipLabel>Driver Details</relationshipLabel>
    <relationshipName>Driver_Details</relationshipName>
    <relationshipOrder>0</relationshipOrder>
    <reparentableMasterDetail>false</reparentableMasterDetail>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>MasterDetail</type>
    <writeRequiresMasterRead>false</writeRequiresMasterRead>
</CustomField>
EOF

# CDL Number field
cat > force-app/main/default/objects/Driver__c/fields/CDL_Number__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>CDL_Number__c</fullName>
    <label>CDL Number</label>
    <length>50</length>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Text</type>
    <unique>true</unique>
</CustomField>
EOF

# CDL Expiration field
cat > force-app/main/default/objects/Driver__c/fields/CDL_Expiration_Date__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>CDL_Expiration_Date__c</fullName>
    <label>CDL Expiration Date</label>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Date</type>
</CustomField>
EOF

# Hazmat Certification field
cat > force-app/main/default/objects/Driver__c/fields/Hazmat_Certified__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Hazmat_Certified__c</fullName>
    <label>Hazmat Certified</label>
    <defaultValue>false</defaultValue>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Checkbox</type>
</CustomField>
EOF

# Hazmat Expiration field
cat > force-app/main/default/objects/Driver__c/fields/Hazmat_Expiration_Date__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Hazmat_Expiration_Date__c</fullName>
    <label>Hazmat Expiration Date</label>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Date</type>
</CustomField>
EOF

# Safety Rating field
cat > force-app/main/default/objects/Driver__c/fields/Safety_Rating__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Safety_Rating__c</fullName>
    <label>Safety Rating</label>
    <precision>3</precision>
    <required>false</required>
    <scale>1</scale>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Number</type>
    <unique>false</unique>
</CustomField>
EOF

# Current Vehicle field
cat > force-app/main/default/objects/Driver__c/fields/Current_Vehicle__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Current_Vehicle__c</fullName>
    <label>Current Vehicle</label>
    <length>100</length>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Text</type>
    <unique>false</unique>
</CustomField>
EOF

# Service Regions field
cat > force-app/main/default/objects/Driver__c/fields/Service_Regions__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Service_Regions__c</fullName>
    <label>Service Regions</label>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>MultiselectPicklist</type>
    <valueSet>
        <valueSetDefinition>
            <sorted>false</sorted>
            <value>
                <fullName>Washington_DC</fullName>
                <default>false</default>
                <label>Washington DC</label>
            </value>
            <value>
                <fullName>Northern_Virginia</fullName>
                <default>false</default>
                <label>Northern Virginia</label>
            </value>
            <value>
                <fullName>Maryland</fullName>
                <default>false</default>
                <label>Maryland</label>
            </value>
            <value>
                <fullName>Delaware</fullName>
                <default>false</default>
                <label>Delaware</label>
            </value>
        </valueSetDefinition>
    </valueSet>
    <visibleLines>4</visibleLines>
</CustomField>
EOF

# Driver Status field
cat > force-app/main/default/objects/Driver__c/fields/Driver_Status__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Driver_Status__c</fullName>
    <label>Driver Status</label>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Picklist</type>
    <valueSet>
        <valueSetDefinition>
            <sorted>false</sorted>
            <value>
                <fullName>Active</fullName>
                <default>true</default>
                <label>Active</label>
            </value>
            <value>
                <fullName>On_Shift</fullName>
                <default>false</default>
                <label>On Shift</label>
            </value>
            <value>
                <fullName>Off_Duty</fullName>
                <default>false</default>
                <label>Off Duty</label>
            </value>
            <value>
                <fullName>Inactive</fullName>
                <default>false</default>
                <label>Inactive</label>
            </value>
        </valueSetDefinition>
    </valueSet>
</CustomField>
EOF

# Total Deliveries field
cat > force-app/main/default/objects/Driver__c/fields/Total_Deliveries__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Total_Deliveries__c</fullName>
    <label>Total Deliveries</label>
    <precision>8</precision>
    <required>false</required>
    <scale>0</scale>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Number</type>
    <unique>false</unique>
</CustomField>
EOF

echo "Driver__c object and fields created successfully!"
echo "Run: sf project deploy start --source-dir force-app"