// FuelBidder Demo Data - Step 1: Base Accounts
// Creates customer and provider accounts across DC metro area

System.debug('🚀 Starting Step 1: Creating Accounts...');

// Customer Accounts - Construction & Government in DC Metro
List<Account> customerAccounts = new List<Account>{
    // Major DC Construction Companies
    new Account(Name='Metro Construction LLC', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='1234 K Street NW', BillingCity='Washington', BillingState='DC', 
               BillingPostalCode='20005', Industry='Construction', NumberOfEmployees=150),
    new Account(Name='Capitol Builders Inc', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='5678 Wisconsin Ave', BillingCity='Bethesda', BillingState='MD',
               BillingPostalCode='20814', Industry='Construction', NumberOfEmployees=85),
    new Account(Name='NoVa Development Group', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='9012 Lee Highway', BillingCity='Fairfax', BillingState='VA',
               BillingPostalCode='22030', Industry='Construction', NumberOfEmployees=120),
    new Account(Name='Potomac Infrastructure Corp', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='3456 Constitution Ave', BillingCity='Washington', BillingState='DC',
               BillingPostalCode='20001', Industry='Construction', NumberOfEmployees=200),
    new Account(Name='DC Highway Department', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='7890 New York Ave', BillingCity='Washington', BillingState='DC',
               BillingPostalCode='20002', Industry='Government', NumberOfEmployees=300),
               
    // Mid-size Regional Contractors
    new Account(Name='Chesapeake Excavation', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='1111 Bay Bridge Rd', BillingCity='Annapolis', BillingState='MD',
               BillingPostalCode='21401', Industry='Construction', NumberOfEmployees=65),
    new Account(Name='Arlington Fleet Services', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='2222 Wilson Blvd', BillingCity='Arlington', BillingState='VA',
               BillingPostalCode='22201', Industry='Transportation', NumberOfEmployees=45),
    new Account(Name='Federal Building Maintenance', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='3333 Federal Plaza', BillingCity='Washington', BillingState='DC',
               BillingPostalCode='20024', Industry='Government', NumberOfEmployees=180),
    new Account(Name='Prince Georges Public Works', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='4444 County Center Dr', BillingCity='Upper Marlboro', BillingState='MD',
               BillingPostalCode='20772', Industry='Government', NumberOfEmployees=250),
    new Account(Name='Loudoun County Fleet', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='5555 Government Center Pkwy', BillingCity='Leesburg', BillingState='VA',
               BillingPostalCode='20175', Industry='Government', NumberOfEmployees=95),
               
    // Smaller Specialty Contractors  
    new Account(Name='DC Demolition Services', Type='Customer - Direct', Provider_Type__c='Owner-Operator',
               BillingStreet='6666 Industrial Blvd', BillingCity='Washington', BillingState='DC',
               BillingPostalCode='20019', Industry='Construction', NumberOfEmployees=35),
    new Account(Name='Maryland Landscaping Co', Type='Customer - Direct', Provider_Type__c='Owner-Operator',
               BillingStreet='7777 Garden Way', BillingCity='Rockville', BillingState='MD',
               BillingPostalCode='20850', Industry='Agriculture', NumberOfEmployees=28),
    new Account(Name='Virginia Utility Services', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='8888 Utility Road', BillingCity='Reston', BillingState='VA',
               BillingPostalCode='20190', Industry='Utilities', NumberOfEmployees=55),
    new Account(Name='Beltway Emergency Response', Type='Customer - Direct', Provider_Type__c='Owner-Operator',
               BillingStreet='9999 Emergency Lane', BillingCity='Silver Spring', BillingState='MD',
               BillingPostalCode='20902', Industry='Transportation', NumberOfEmployees=42),
    new Account(Name='Regional Concrete Supply', Type='Customer - Direct', Provider_Type__c='Company',
               BillingStreet='1010 Mixer Drive', BillingCity='Alexandria', BillingState='VA',
               BillingPostalCode='22314', Industry='Construction', NumberOfEmployees=38)
};

insert customerAccounts;
System.debug('✅ Created ' + customerAccounts.size() + ' customer accounts');

// Provider Accounts - Fuel Suppliers and Logistics Companies
List<Account> providerAccounts = new List<Account>{
    new Account(Name='Diamond Fuel Delivery', Type='Customer - Channel', Provider_Type__c='Company',
               BillingStreet='1100 Fuel Terminal Dr', BillingCity='Baltimore', BillingState='MD',
               BillingPostalCode='21224', Industry='Energy', NumberOfEmployees=85),
    new Account(Name='Capital Energy Services', Type='Customer - Channel', Provider_Type__c='Company',
               BillingStreet='2200 Energy Way', BillingCity='Arlington', BillingState='VA',
               BillingPostalCode='22201', Industry='Energy', NumberOfEmployees=120),
    new Account(Name='Potomac Petroleum LLC', Type='Customer - Channel', Provider_Type__c='Company',
               BillingStreet='3300 Refinery Road', BillingCity='Alexandria', BillingState='VA',
               BillingPostalCode='22314', Industry='Energy', NumberOfEmployees=95),
    new Account(Name='Metro Logistics Corp', Type='Customer - Channel', Provider_Type__c='Company',
               BillingStreet='4400 Distribution Ave', BillingCity='Laurel', BillingState='MD',
               BillingPostalCode='20707', Industry='Transportation', NumberOfEmployees=75),
    new Account(Name='Regional Fuel Solutions', Type='Customer - Channel', Provider_Type__c='Company',
               BillingStreet='5500 Commerce Blvd', BillingCity='Fairfax', BillingState='VA',
               BillingPostalCode='22030', Industry='Energy', NumberOfEmployees=110)
};

insert providerAccounts;
System.debug('✅ Created ' + providerAccounts.size() + ' provider accounts');

System.debug('🎉 Step 1 Complete!');
System.debug('Total Accounts Created: ' + (customerAccounts.size() + providerAccounts.size()));
System.debug('- Customer Accounts: ' + customerAccounts.size());
System.debug('- Provider Accounts: ' + providerAccounts.size());
System.debug('Ready for Step 2: Contacts');