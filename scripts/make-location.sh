#!/bin/bash

# Run from project root (fuelbidder/)

echo "Creating Location__c object..."
cat > force-app/main/default/objects/Location__c/Location__c.object-meta.xml << 'EOF'
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
    <label>Location</label>
    <nameField>
        <label>Location Name</label>
        <type>Text</type>
    </nameField>
    <pluralLabel>Locations</pluralLabel>
    <searchLayouts/>
    <sharingModel>ControlledByParent</sharingModel>
    <visibility>Public</visibility>
</CustomObject>
EOF

# Create ALL Location Fields
echo "Creating all Location__c fields..."

# Create fields directory (in case it doesn't exist)
mkdir -p force-app/main/default/objects/Location__c/fields

# Account relationship field (Master-Detail)
cat > force-app/main/default/objects/Location__c/fields/Account__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Account__c</fullName>
    <label>Customer Account</label>
    <referenceTo>Account</referenceTo>
    <relationshipLabel>Locations</relationshipLabel>
    <relationshipName>Locations</relationshipName>
    <relationshipOrder>0</relationshipOrder>
    <reparentableMasterDetail>false</reparentableMasterDetail>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>MasterDetail</type>
    <writeRequiresMasterRead>false</writeRequiresMasterRead>
</CustomField>
EOF

# Site Contact Name field
cat > force-app/main/default/objects/Location__c/fields/Site_Contact_Name__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Site_Contact_Name__c</fullName>
    <label>Site Contact Name</label>
    <length>80</length>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Text</type>
    <unique>false</unique>
</CustomField>
EOF

# Site Contact Phone field
cat > force-app/main/default/objects/Location__c/fields/Site_Contact_Phone__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Site_Contact_Phone__c</fullName>
    <label>Site Contact Phone</label>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Phone</type>
</CustomField>
EOF

# Location Hours field
cat > force-app/main/default/objects/Location__c/fields/Location_Hours__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Location_Hours__c</fullName>
    <label>Location Hours</label>
    <length>100</length>
    <required>false</required>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Text</type>
    <unique>false</unique>
</CustomField>
EOF

# Tank Access Hours field
cat > force-app/main/default/objects/Location__c/fields/Tank_Access_Hours__c.field-meta.xml << 'EOF'
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

# Is Manned field
cat > force-app/main/default/objects/Location__c/fields/Is_Manned__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Is_Manned__c</fullName>
    <label>Location Is Manned</label>
    <defaultValue>false</defaultValue>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Checkbox</type>
</CustomField>
EOF

# Is Locked field
cat > force-app/main/default/objects/Location__c/fields/Is_Locked__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Is_Locked__c</fullName>
    <label>Location Is Locked</label>
    <defaultValue>false</defaultValue>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Checkbox</type>
</CustomField>
EOF

# Access Instructions field
cat > force-app/main/default/objects/Location__c/fields/Access_Instructions__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Access_Instructions__c</fullName>
    <label>Access Instructions</label>
    <length>32768</length>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>LongTextArea</type>
    <visibleLines>3</visibleLines>
</CustomField>
EOF

# Location Notes field
cat > force-app/main/default/objects/Location__c/fields/Location_Notes__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Location_Notes__c</fullName>
    <label>Location Notes</label>
    <length>32768</length>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>LongTextArea</type>
    <visibleLines>3</visibleLines>
</CustomField>
EOF

# Primary Location field
cat > force-app/main/default/objects/Location__c/fields/Primary_Location__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Primary_Location__c</fullName>
    <label>Primary Location</label>
    <defaultValue>false</defaultValue>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Checkbox</type>
</CustomField>
EOF

# Active field
cat > force-app/main/default/objects/Location__c/fields/Active__c.field-meta.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Active__c</fullName>
    <label>Active</label>
    <defaultValue>true</defaultValue>
    <trackHistory>false</trackHistory>
    <trackTrending>false</trackTrending>
    <type>Checkbox</type>
</CustomField>
EOF

echo "All Location__c fields created successfully!"
echo "Run: sf project deploy start --source-dir force-app/main/default/objects/Location__c/fields"