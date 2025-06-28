// FuelBidder Demo Data - Step 0: Cleanup
// Deletes existing demo data to make scripts idempotent

System.debug('🧹 Starting Cleanup: Removing existing demo data...');

// Delete in reverse dependency order to avoid foreign key constraints

// Step 1: Delete Tanks (depend on Locations)
List<Tank__c> existingTanks = [SELECT Id FROM Tank__c];
if(!existingTanks.isEmpty()) {
    delete existingTanks;
    System.debug('✅ Deleted ' + existingTanks.size() + ' existing tanks');
}

// Step 2: Delete Locations (depend on Accounts)
List<Location__c> existingLocations = [SELECT Id FROM Location__c];
if(!existingLocations.isEmpty()) {
    delete existingLocations;
    System.debug('✅ Deleted ' + existingLocations.size() + ' existing locations');
}

// Step 3: Delete Contacts (depend on Accounts)
List<Contact> existingContacts = [SELECT Id FROM Contact WHERE Account.Type IN ('Customer - Direct', 'Customer - Channel')];
if(!existingContacts.isEmpty()) {
    delete existingContacts;
    System.debug('✅ Deleted ' + existingContacts.size() + ' existing contacts');
}

// Step 4: Delete Provider records (depend on Accounts)
List<Provider__c> existingProviders = [SELECT Id FROM Provider__c];
if(!existingProviders.isEmpty()) {
    delete existingProviders;
    System.debug('✅ Deleted ' + existingProviders.size() + ' existing providers');
}

// Step 5: Delete demo Accounts (root level)
List<Account> existingAccounts = [SELECT Id FROM Account WHERE Type IN ('Customer - Direct', 'Customer - Channel')];
if(!existingAccounts.isEmpty()) {
    delete existingAccounts;
    System.debug('✅ Deleted ' + existingAccounts.size() + ' existing accounts');
}

// Step 6: Delete demo Leads
List<Lead> existingLeads = [SELECT Id FROM Lead WHERE Company LIKE '%Demo%' OR Company LIKE '%Test%' OR Email LIKE '%demo%'];
if(!existingLeads.isEmpty()) {
    delete existingLeads;
    System.debug('✅ Deleted ' + existingLeads.size() + ' existing leads');
}

System.debug('🎉 Cleanup Complete!');
System.debug('Ready for fresh demo data creation');