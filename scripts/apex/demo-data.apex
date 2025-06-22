// 1. Create Customer Accounts
List<Account> customerAccounts = new List<Account>{
    new Account(Name='Metro Construction LLC', Type='Customer - Direct'),
    new Account(Name='Capitol Builders Inc', Type='Customer - Direct'),
    new Account(Name='NoVa Development Group', Type='Customer - Direct'),
    new Account(Name='Potomac Infrastructure', Type='Customer - Direct'),
    new Account(Name='DC Highway Department', Type='Customer - Direct')
};
insert customerAccounts;
System.debug('Created ' + customerAccounts.size() + ' customer accounts');

// 2. Create Provider Accounts  
List<Account> providerAccounts = new List<Account>{
    new Account(Name='Diamond Fuel Delivery', Type='Customer - Channel'),
    new Account(Name='Capital Energy Services', Type='Customer - Channel'),
    new Account(Name='Metro Petroleum LLC', Type='Customer - Channel')
};
insert providerAccounts;
System.debug('Created ' + providerAccounts.size() + ' provider accounts');

// 3. Create Locations
List<Location__c> locations = new List<Location__c>{
    new Location__c(Name='Metro Construction - Downtown Site', Account__c=customerAccounts[0].Id,
                   Street_Address__c='1234 K Street NW', City__c='Washington', State__c='DC', Zip_Code__c='20005'),
    new Location__c(Name='Capitol Builders - Bethesda Office', Account__c=customerAccounts[1].Id,
                   Street_Address__c='5678 Wisconsin Ave', City__c='Bethesda', State__c='MD', Zip_Code__c='20814'),
    new Location__c(Name='NoVa Development - Fairfax HQ', Account__c=customerAccounts[2].Id,
                   Street_Address__c='9012 Lee Highway', City__c='Fairfax', State__c='VA', Zip_Code__c='22030'),
    new Location__c(Name='Potomac Infrastructure - Main Yard', Account__c=customerAccounts[3].Id,
                   Street_Address__c='3456 Constitution Ave', City__c='Washington', State__c='DC', Zip_Code__c='20001'),
    new Location__c(Name='DC Highway - Equipment Depot', Account__c=customerAccounts[4].Id,
                   Street_Address__c='7890 New York Ave', City__c='Washington', State__c='DC', Zip_Code__c='20002')
};
insert locations;
System.debug('Created ' + locations.size() + ' locations');

// 4. Create Tanks
List<Tank__c> tanks = new List<Tank__c>{
    new Tank__c(Name='Tank A - Diesel Storage', Location__c=locations[0].Id, 
               Fuel_Type__c='Diesel', Capacity_Gallons__c=5000),
    new Tank__c(Name='Tank A - Office Generator', Location__c=locations[1].Id, 
               Fuel_Type__c='Diesel', Capacity_Gallons__c=2000),
    new Tank__c(Name='Tank A - Primary Storage', Location__c=locations[2].Id, 
               Fuel_Type__c='Diesel', Capacity_Gallons__c=15000),
    new Tank__c(Name='Tank A - Heavy Equipment', Location__c=locations[3].Id, 
               Fuel_Type__c='Diesel', Capacity_Gallons__c=20000),
    new Tank__c(Name='Tank A - Road Equipment', Location__c=locations[4].Id, 
               Fuel_Type__c='Diesel', Capacity_Gallons__c=15000)
};
insert tanks;
System.debug('Created ' + tanks.size() + ' tanks');

System.debug('🎉 GUARANTEED DEMO DATA CREATED!');
System.debug('- 8 Accounts (5 customers + 3 providers)');
System.debug('- 5 Construction locations across DC metro');
System.debug('- 5 Diesel tanks with working relationships');
System.debug('- Proves complete Account → Location → Tank hierarchy!');
