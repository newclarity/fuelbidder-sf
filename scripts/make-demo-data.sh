#!/usr/bin/env bash
REPO_ROOT="$(git rev-parse --show-toplevel)"
cat > "${REPO_ROOT}/scripts/apex/demo-data.apex" << 'EOF'
// 1. Create Customer Accounts
List<Account> customerAccounts = new List<Account>{
    new Account(Name='Metro Construction LLC', Type='Customer - Direct',
               BillingStreet='1234 K Street NW', BillingCity='Washington', BillingState='DC', BillingPostalCode='20005',
               Phone='(202) 555-0101', Website='www.metroconstruction.com'),
    new Account(Name='Capitol Builders Inc', Type='Customer - Direct',
               BillingStreet='5678 Wisconsin Ave', BillingCity='Bethesda', BillingState='MD', BillingPostalCode='20814',
               Phone='(301) 555-0102', Website='www.capitolbuilders.com'),
    new Account(Name='NoVa Development Group', Type='Customer - Direct',
               BillingStreet='9012 Lee Highway', BillingCity='Fairfax', BillingState='VA', BillingPostalCode='22030',
               Phone='(703) 555-0103', Website='www.novadevelopment.com'),
    new Account(Name='Potomac Infrastructure', Type='Customer - Direct',
               BillingStreet='3456 Constitution Ave', BillingCity='Washington', BillingState='DC', BillingPostalCode='20001',
               Phone='(202) 555-0104', Website='www.potomacinfra.gov'),
    new Account(Name='DC Highway Department', Type='Customer - Direct',
               BillingStreet='7890 New York Ave', BillingCity='Washington', BillingState='DC', BillingPostalCode='20002',
               Phone='(202) 555-0105', Website='www.dchighway.gov')
};
insert customerAccounts;
System.debug('Created ' + customerAccounts.size() + ' customer accounts');

// 2. Create Provider Accounts
List<Account> providerAccounts = new List<Account>{
    new Account(Name='Diamond Fuel Delivery', Type='Customer - Channel',
               BillingStreet='1100 Fuel Terminal Dr', BillingCity='Baltimore', BillingState='MD', BillingPostalCode='21224',
               Phone='(410) 555-0201', Website='www.diamondfuel.com'),
    new Account(Name='Capital Energy Services', Type='Customer - Channel',
               BillingStreet='2200 Energy Way', BillingCity='Arlington', BillingState='VA', BillingPostalCode='22201',
               Phone='(703) 555-0202', Website='www.capitalenergy.com'),
    new Account(Name='Metro Petroleum LLC', Type='Customer - Channel',
               BillingStreet='3300 Truck Stop Ln', BillingCity='Laurel', BillingState='MD', BillingPostalCode='20707',
               Phone='(301) 555-0203', Website='www.metropetroleum.com')
};
insert providerAccounts;
System.debug('Created ' + providerAccounts.size() + ' provider accounts');

// 3. Create Locations
List<Location__c> locations = new List<Location__c>{
    new Location__c(Name='Metro Construction - Downtown Site', Account__c=customerAccounts[0].Id,
                   Street_Address__c='1234 K Street NW', City__c='Washington', State__c='DC', Zip_Code__c='20005'),
    new Location__c(Name='Metro Construction - Georgetown Project', Account__c=customerAccounts[0].Id,
                   Street_Address__c='2500 M Street NW', City__c='Washington', State__c='DC', Zip_Code__c='20037'),
    new Location__c(Name='Capitol Builders - Bethesda Office', Account__c=customerAccounts[1].Id,
                   Street_Address__c='5678 Wisconsin Ave', City__c='Bethesda', State__c='MD', Zip_Code__c='20814'),
    new Location__c(Name='Capitol Builders - Silver Spring Site', Account__c=customerAccounts[1].Id,
                   Street_Address__c='8901 Georgia Ave', City__c='Silver Spring', State__c='MD', Zip_Code__c='20910'),
    new Location__c(Name='NoVa Development - Fairfax HQ', Account__c=customerAccounts[2].Id,
                   Street_Address__c='9012 Lee Highway', City__c='Fairfax', State__c='VA', Zip_Code__c='22030'),
    new Location__c(Name='NoVa Development - Tysons Project', Account__c=customerAccounts[2].Id,
                   Street_Address__c='1234 Tysons Blvd', City__c='McLean', State__c='VA', Zip_Code__c='22102'),
    new Location__c(Name='Potomac Infrastructure - Main Yard', Account__c=customerAccounts[3].Id,
                   Street_Address__c='3456 Constitution Ave', City__c='Washington', State__c='DC', Zip_Code__c='20001'),
    new Location__c(Name='DC Highway - Equipment Depot', Account__c=customerAccounts[4].Id,
                   Street_Address__c='7890 New York Ave', City__c='Washington', State__c='DC', Zip_Code__c='20002')
};
insert locations;
System.debug('Created ' + locations.size() + ' locations');

// 4. Create Tanks with IoT devices
List<Tank__c> tanks = new List<Tank__c>{
    new Tank__c(Name='Tank A - Diesel Storage', Location__c=locations[0].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=5000, Current_Level_Gallons__c=1200, Low_Level_Threshold__c=500,
               Has_IoT_Device__c=true, IoT_Device_ID__c='IOT-001-DC', Active_Tank__c=true),
    new Tank__c(Name='Tank B - Generator Backup', Location__c=locations[0].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=1000, Current_Level_Gallons__c=350, Low_Level_Threshold__c=100,
               Has_IoT_Device__c=false, Active_Tank__c=true),
    new Tank__c(Name='Tank A - Main Diesel', Location__c=locations[1].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=10000, Current_Level_Gallons__c=2500, Low_Level_Threshold__c=1000,
               Has_IoT_Device__c=true, IoT_Device_ID__c='IOT-002-GT', Active_Tank__c=true),
    new Tank__c(Name='Tank A - Office Generator', Location__c=locations[2].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=2000, Current_Level_Gallons__c=800, Low_Level_Threshold__c=200,
               Has_IoT_Device__c=false, Active_Tank__c=true),
    new Tank__c(Name='Tank B - Equipment Fuel', Location__c=locations[3].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=8000, Current_Level_Gallons__c=1800, Low_Level_Threshold__c=800,
               Has_IoT_Device__c=true, IoT_Device_ID__c='IOT-003-SS', Active_Tank__c=true),
    new Tank__c(Name='Tank A - Primary Storage', Location__c=locations[4].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=15000, Current_Level_Gallons__c=4500, Low_Level_Threshold__c=2000,
               Has_IoT_Device__c=true, IoT_Device_ID__c='IOT-004-FX', Active_Tank__c=true),
    new Tank__c(Name='Tank A - Construction Diesel', Location__c=locations[5].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=12000, Current_Level_Gallons__c=3200, Low_Level_Threshold__c=1500,
               Has_IoT_Device__c=true, IoT_Device_ID__c='IOT-005-TY', Active_Tank__c=true),
    new Tank__c(Name='Tank A - Heavy Equipment', Location__c=locations[6].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=20000, Current_Level_Gallons__c=5800, Low_Level_Threshold__c=3000,
               Has_IoT_Device__c=true, IoT_Device_ID__c='IOT-006-PI', Active_Tank__c=true),
    new Tank__c(Name='Tank A - Road Equipment', Location__c=locations[7].Id, Fuel_Type__c='Diesel',
               Capacity_Gallons__c=15000, Current_Level_Gallons__c=4200, Low_Level_Threshold__c=2000,
               Has_IoT_Device__c=true, IoT_Device_ID__c='IOT-008-DC', Active_Tank__c=true)
};
insert tanks;
System.debug('Created ' + tanks.size() + ' tanks');

// 5. Create Provider Details
List<Provider__c> providers = new List<Provider__c>{
    new Provider__c(Name='Diamond Fuel Provider Details', Account__c=providerAccounts[0].Id,
                   Insurance_Certificate_Number__c='INS-001-DF', Safety_Rating__c=4.8,
                   Fleet_Size__c=12, Active_Provider__c=true, Minimum_Order_Gallons__c=500),
    new Provider__c(Name='Capital Energy Provider Details', Account__c=providerAccounts[1].Id,
                   Insurance_Certificate_Number__c='INS-002-CE', Safety_Rating__c=4.6,
                   Fleet_Size__c=8, Active_Provider__c=true, Minimum_Order_Gallons__c=750),
    new Provider__c(Name='Metro Petroleum Provider Details', Account__c=providerAccounts[2].Id,
                   Insurance_Certificate_Number__c='INS-003-MP', Safety_Rating__c=4.9,
                   Fleet_Size__c=3, Active_Provider__c=true, Minimum_Order_Gallons__c=250)
};
insert providers;
System.debug('Created ' + providers.size() + ' provider details');

// 6. Create Driver Contacts
List<Contact> drivers = new List<Contact>{
    new Contact(FirstName='Carlos', LastName='Rodriguez', Email='carlos.rodriguez@diamondfuel.com',
               Phone='(410) 555-0301', MobilePhone='(410) 555-0401', AccountId=providerAccounts[0].Id),
    new Contact(FirstName='Maria', LastName='Gonzalez', Email='maria.gonzalez@diamondfuel.com',
               Phone='(410) 555-0302', MobilePhone='(410) 555-0402', AccountId=providerAccounts[0].Id),
    new Contact(FirstName='James', LastName='Wilson', Email='james.wilson@diamondfuel.com',
               Phone='(410) 555-0303', MobilePhone='(410) 555-0403', AccountId=providerAccounts[0].Id),
    new Contact(FirstName='Patricia', LastName='Johnson', Email='patricia.johnson@capitalenergy.com',
               Phone='(703) 555-0304', MobilePhone='(703) 555-0404', AccountId=providerAccounts[1].Id),
    new Contact(FirstName='Michael', LastName='Brown', Email='michael.brown@capitalenergy.com',
               Phone='(703) 555-0305', MobilePhone='(703) 555-0405', AccountId=providerAccounts[1].Id),
    new Contact(FirstName='Tony', LastName='Ricci', Email='tony@metropetroleum.com',
               Phone='(301) 555-0306', MobilePhone='(301) 555-0406', AccountId=providerAccounts[2].Id)
};
insert drivers;
System.debug('Created ' + drivers.size() + ' driver contacts');

System.debug('🎉 IMPRESSIVE DEMO DATA CREATED!');
System.debug('Your demo now has:');
System.debug('- 8 Accounts (5 customers + 3 providers)');
System.debug('- 8 Locations across DC metro area');
System.debug('- 9 Tanks (7 with IoT devices!)');
System.debug('- 3 Provider companies with safety ratings');
System.debug('- 6 Professional drivers ready to work');
System.debug('- Complete fuel delivery marketplace! 🚀');
EOF