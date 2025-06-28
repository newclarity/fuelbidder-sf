// Diagnostic script to understand Account object requirements
// Run: sf apex run --file scripts/debug-account-fields.apex --target-org fuelbidder-dev

System.debug('🔍 ACCOUNT OBJECT FIELD ANALYSIS');
System.debug('================================');

// Get Account object describe
Schema.SObjectType accountType = Schema.getGlobalDescribe().get('Account');
Schema.DescribeSObjectResult accountDescribe = accountType.getDescribe();

System.debug('Account Object Label: ' + accountDescribe.getLabel());
System.debug('');

// Find all required fields
System.debug('REQUIRED FIELDS:');
System.debug('================');
Map<String, Schema.SObjectField> fieldMap = accountDescribe.fields.getMap();

for(String fieldName : fieldMap.keySet()) {
    Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();

    if(!fieldDescribe.isNillable() && fieldDescribe.isCreateable() && !fieldDescribe.isDefaultedOnCreate()) {
        System.debug('REQUIRED: ' + fieldName + ' (' + fieldDescribe.getLabel() + ') - Type: ' + fieldDescribe.getType());

        // If it's a picklist, show the values
        if(fieldDescribe.getType() == Schema.DisplayType.PICKLIST) {
            List<Schema.PicklistEntry> picklistValues = fieldDescribe.getPicklistValues();
            System.debug('  Picklist Values:');
            for(Schema.PicklistEntry entry : picklistValues) {
                if(entry.isActive()) {
                    System.debug('    - ' + entry.getValue() + (entry.isDefaultValue() ? ' (DEFAULT)' : ''));
                }
            }
        }
        System.debug('');
    }
}

// Check specifically for Provider_Type__c field
System.debug('PROVIDER_TYPE__C FIELD ANALYSIS:');
System.debug('=================================');
if(fieldMap.containsKey('provider_type__c')) {
    Schema.DescribeFieldResult providerTypeField = fieldMap.get('provider_type__c').getDescribe();
    System.debug('Label: ' + providerTypeField.getLabel());
    System.debug('Type: ' + providerTypeField.getType());
    System.debug('Required: ' + (!providerTypeField.isNillable() && providerTypeField.isCreateable()));
    System.debug('Help Text: ' + providerTypeField.getInlineHelpText());

    if(providerTypeField.getType() == Schema.DisplayType.PICKLIST) {
        System.debug('Picklist Values:');
        List<Schema.PicklistEntry> picklistValues = providerTypeField.getPicklistValues();
        for(Schema.PicklistEntry entry : picklistValues) {
            if(entry.isActive()) {
                System.debug('  - ' + entry.getValue() + (entry.isDefaultValue() ? ' (DEFAULT)' : ''));
            }
        }
    }
} else {
    System.debug('Provider_Type__c field not found in Account object');
}

System.debug('');
System.debug('🎯 ANALYSIS COMPLETE');
System.debug('Use this info to fix the account creation script!');