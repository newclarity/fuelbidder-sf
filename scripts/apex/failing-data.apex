// Create Demo Data for 11am Meeting - USING STANDARD TYPE FIELD
// Run: sf apex run --file create_demo_data.apex

// 1. Create Customer Accounts (using standard Type field)
List<Account> customerAccounts = new List<Account>{
    new Account(Name='Metro Construction LLC', Type='Customer - Direct',
               BillingStreet='1234 K Street NW', BillingCity='Washington', BillingState='DC', BillingPostalCode='20005'),
    new Account(Name='Capitol Builders Inc', Type='Customer - Direct',
               BillingStreet='5678 Wisconsin Ave', BillingCity='Bethesda', BillingState='MD', BillingPostalCode='20814'),
    new Account(Name='NoVa Development Group', Type='Customer - Direct',
               BillingStreet='9012 Lee Highway', BillingCity='Fairfax', BillingState='VA', BillingPostalCode='22030')
};
insert customerAccounts;
System.debug('Created ' + customerAccounts.size() + ' customer accounts');

// 2. Create Provider Accounts
List<Account> providerAccounts = new List<Account>{
    new Account(Name='Diamond Fuel Delivery', Type='Customer - Channel',
               BillingStreet='1100 Fuel Terminal Dr', BillingCity='Baltimore', BillingState='MD', BillingPostalCode='21224'),
    new Account(Name='Capital Energy Services', Type='Customer - Channel',
               BillingStreet='2200 Energy Way', BillingCity='Arlington', BillingState='VA', BillingPostalCode='22201')
};
insert providerAccounts;
System.debug('Created ' + providerAccounts.size() + ' provider accounts');

// 3. Create Locations
List<Location__c> locations = new List<Location__c>{
    new Location__c(Name='Metro Construction - Downtown Site', Account__c=customerAccounts[0].Id,
                   Street_Address__c='1234 K Street NW', City__c='Washington', State__c='DC', Zip_Code__c='20005',
                   Site_Contact_Name__c='Mike Johnson', Site_Contact_Phone__c='(202) 555-0111',
                   Location_Hours__c='Mon-Fri 6AM-6PM', Is_Manned__c=true, Is_Locked__c=true, Primary_Location__c=true, Active__c=true),
    new Location__c(Name='Capitol Builders - Bethesda Office', Account__c=customerAccounts[1].Id,
                   Street_Address__c='5678 Wisconsin Ave', City__c='Bethesda', State__c='MD', Zip_Code__c='20814',
                   Site_Contact_Name__c='Tom Anderson', Site_Contact_Phone__c='(301) 555-0113',
                   Location_Hours__c='Mon-Fri 8AM-5PM', Is_Manned__c=true, Is_Locked__c=false, Primary_Location__c=true, Active__c=true),
    new Location__c(Name='NoVa Development - Fairfax HQ', Account__c=customerAccounts[2].Id,
                   Street_Address__c='9012 Lee Highway', City__c='Fairfax', State__c='VA', Zip_Code__c='22030',
                   Site_Contact_Name__c='David Brown', Site_Contact_Phone__c='(703) 555-0115',
                   Location_Hours__c='Mon-Fri 7AM-6PM', Is_Manned__c=true, Is_Locked__c=false, Primary_Location__c=true, Active__c=true)
};
insert locations;
System.debug('Created ' + locations.size() + ' locations');

// 4. Create Tanks
List<Tank__c> tanks = new List<Tank__c>{
    new Tank__c(Name='Tank A - Diesel Storage', Location__c=locations[0].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=5000, Current_Level_Gallons__c=1200, Low_Level_Threshold__c=500,
               Has_IoT_Device__c=true, IoT_Device_ID__c='IOT-001-DC', Tank_Access_Hours__c='Same as location', Active_Tank__c=true),
    new Tank__c(Name='Tank B - Generator Backup', Location__c=locations[0].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=1000, Current_Level_Gallons__c=350, Low_Level_Threshold__c=100,
               Has_IoT_Device__c=false, Tank_Access_Hours__c='Same as location', Active_Tank__c=true),
    new Tank__c(Name='Tank A - Office Generator', Location__c=locations[1].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=2000, Current_Level_Gallons__c=800, Low_Level_Threshold__c=200,
               Has_IoT_Device__c=false, Tank_Access_Hours__c='Same as location', Active_Tank__c=true),
    new Tank__c(Name='Tank A - Primary Storage', Location__c=locations[2].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=15000, Current_Level_Gallons__c=4500, Low_Level_Threshold__c=2000,
               Has_IoT_Device__c=true, IoT_Device_ID__c='IOT-004-FX', Tank_Access_Hours__c='Same as location', Active_Tank__c=true)
};
insert tanks;
System.debug('Created ' + tanks.size() + ' tanks');

// 5. Create Provider Details
List<Provider__c> providers = new List<Provider__c>{
    new Provider__c(Name='Diamond Fuel Provider Details', Account__c=providerAccounts[0].Id,
                   Insurance_Certificate_Number__c='INS-001-DF', Insurance_Expiration_Date__c=Date.valueOf('2025-12-31'),
                   Safety_Rating__c=4.8, Service_Regions__c='Washington_DC;Maryland;Northern_Virginia',
                   Fleet_Size__c=12, Active_Provider__c=true, Minimum_Order_Gallons__c=500),
    new Provider__c(Name='Capital Energy Provider Details', Account__c=providerAccounts[1].Id,
                   Insurance_Certificate_Number__c='INS-002-CE', Insurance_Expiration_Date__c=Date.valueOf('2025-11-30'),
                   Safety_Rating__c=4.6, Service_Regions__c='Washington_DC;Northern_Virginia',
                   Fleet_Size__c=8, Active_Provider__c=true, Minimum_Order_Gallons__c=750)
};
insert providers;
System.debug('Created ' + providers.size() + ' provider details');

// 6. Create Driver Contacts
List<Contact> drivers = new List<Contact>{
    new Contact(FirstName='Carlos', LastName='Rodriguez', Email='carlos.rodriguez@diamondfuel.com',
               Phone='(410) 555-0301', MobilePhone='(410) 555-0401', AccountId=providerAccounts[0].Id),
    new Contact(FirstName='Maria', LastName='Gonzalez', Email='maria.gonzalez@diamondfuel.com',
               Phone='(410) 555-0302', MobilePhone='(410) 555-0402', AccountId=providerAccounts[0].Id),
    new Contact(FirstName='Patricia', LastName='Johnson', Email='patricia.johnson@capitalenergy.com',
               Phone='(703) 555-0304', MobilePhone='(703) 555-0404', AccountId=providerAccounts[1].Id),
    new Contact(FirstName='Michael', LastName='Brown', Email='michael.brown@capitalenergy.com',
               Phone='(703) 555-0305', MobilePhone='(703) 555-0405', AccountId=providerAccounts[1].Id)
};
insert drivers;
System.debug('Created ' + drivers.size() + ' driver contacts');

System.debug('🎉 DEMO DATA CREATION COMPLETE!');
System.debug('Your 11am demo is ready with:');
System.debug('- 5 Accounts (3 customers + 2 providers)');
System.debug('- 3 Locations across DC metro');
System.debug('- 4 Tanks (2 with IoT devices)');
System.debug('- 2 Provider details');
System.debug('- 4 Driver contacts');
System.debug('Ready to demo! 🚀');