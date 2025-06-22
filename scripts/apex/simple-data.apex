// 1. Create Customer Accounts
List<Account> customerAccounts = new List<Account>{
    new Account(Name='Metro Construction LLC', Type='Customer - Direct'),
    new Account(Name='Capitol Builders Inc', Type='Customer - Direct'),
    new Account(Name='NoVa Development Group', Type='Customer - Direct')
};
insert customerAccounts;
System.debug('Created ' + customerAccounts.size() + ' customer accounts');

// 2. Create Provider Accounts  
List<Account> providerAccounts = new List<Account>{
    new Account(Name='Diamond Fuel Delivery', Type='Customer - Channel'),
    new Account(Name='Capital Energy Services', Type='Customer - Channel')
};
insert providerAccounts;
System.debug('Created ' + providerAccounts.size() + ' provider accounts');

// 3. Create Locations (only using confirmed fields)
List<Location__c> locations = new List<Location__c>{
    new Location__c(Name='Metro Construction - Downtown Site', Account__c=customerAccounts[0].Id,
                   Street_Address__c='1234 K Street NW', City__c='Washington', State__c='DC', Zip_Code__c='20005'),
    new Location__c(Name='Capitol Builders - Bethesda Office', Account__c=customerAccounts[1].Id,
                   Street_Address__c='5678 Wisconsin Ave', City__c='Bethesda', State__c='MD', Zip_Code__c='20814'),
    new Location__c(Name='NoVa Development - Fairfax HQ', Account__c=customerAccounts[2].Id,
                   Street_Address__c='9012 Lee Highway', City__c='Fairfax', State__c='VA', Zip_Code__c='22030')
};
insert locations;
System.debug('Created ' + locations.size() + ' locations');

System.debug('🎉 WORKING DEMO DATA CREATED!');
System.debug('Ready for 11am demo! 🚀');
