// Diagnostic for Location__c fields
System.debug('🔍 LOCATION__C OBJECT FIELD ANALYSIS');

Schema.SObjectType locationType = Schema.getGlobalDescribe().get('Location__c');
if(locationType != null) {
    Schema.DescribeSObjectResult locationDescribe = locationType.getDescribe();
    Map<String, Schema.SObjectField> fieldMap = locationDescribe.fields.getMap();

    System.debug('Available Location__c fields:');
    for(String fieldName : fieldMap.keySet()) {
        Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
        if(fieldDescribe.isCreateable()) {
            System.debug('- ' + fieldName + ' (' + fieldDescribe.getLabel() + ')');
        }
    }
} else {
    System.debug('Location__c object not found');
}