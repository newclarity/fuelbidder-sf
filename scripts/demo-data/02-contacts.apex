// FuelBidder Demo Data - Step 2: Contacts
// Creates contacts for accounts created in Step 1

System.debug('🚀 Starting Step 2: Creating Contacts...');

// Query accounts created in Step 1
List<Account> customerAccounts = [SELECT Id, Name FROM Account WHERE Type = 'Customer - Direct' ORDER BY Name];
List<Account> providerAccounts = [SELECT Id, Name FROM Account WHERE Type = 'Customer - Channel' ORDER BY Name];

System.debug('Found ' + customerAccounts.size() + ' customer accounts');
System.debug('Found ' + providerAccounts.size() + ' provider accounts');

List<Contact> allContacts = new List<Contact>();

// Create Customer Contacts (2-4 per account with realistic roles)
String[] firstNames = new String[]{'Michael', 'Sarah', 'David', 'Jennifer', 'Robert', 'Lisa', 'James', 'Amanda', 'Carlos', 'Maria', 'Patricia', 'John', 'Mary', 'William', 'Elizabeth', 'Richard', 'Karen', 'Thomas', 'Nancy', 'Matthew'};
String[] customerTitles = new String[]{'Fleet Operations Manager', 'Fuel Procurement Specialist', 'Site Supervisor', 'Project Coordinator', 'Operations Director', 'Facilities Manager', 'Equipment Manager', 'Safety Coordinator'};
String[] customerDepts = new String[]{'Operations', 'Procurement', 'Field Operations', 'Safety', 'Facilities', 'Equipment'};

Integer nameIndex = 0;
for(Account acc : customerAccounts) {
    String companyDomain = acc.Name.toLowerCase().replace(' ', '').replace('-', '').replace('&', '').replace('.', '') + '.com';
    
    // Primary contact (always create)
    allContacts.add(new Contact(
        AccountId = acc.Id,
        FirstName = firstNames[Math.mod(nameIndex++, firstNames.size())],
        LastName = getRandomLastName(),
        Email = 'primary@' + companyDomain,
        Phone = generatePhone(),
        Title = customerTitles[Math.mod(nameIndex, customerTitles.size())],
        Department = customerDepts[Math.mod(nameIndex, customerDepts.size())]
    ));
    
    // Secondary contact (always create)
    allContacts.add(new Contact(
        AccountId = acc.Id,
        FirstName = firstNames[Math.mod(nameIndex++, firstNames.size())],
        LastName = getRandomLastName(),
        Email = 'secondary@' + companyDomain,
        Phone = generatePhone(),
        Title = customerTitles[Math.mod(nameIndex, customerTitles.size())],
        Department = customerDepts[Math.mod(nameIndex, customerDepts.size())]
    ));
    
    // Third contact (50% chance for larger companies)
    if(Math.mod(nameIndex, 2) == 0) {
        allContacts.add(new Contact(
            AccountId = acc.Id,
            FirstName = firstNames[Math.mod(nameIndex++, firstNames.size())],
            LastName = getRandomLastName(),
            Email = 'field@' + companyDomain,
            Phone = generatePhone(),
            Title = 'Field Coordinator',
            Department = 'Field Operations'
        ));
    }
}

// Create Provider Contacts (3-5 per provider)
String[] providerTitles = new String[]{'Distribution Manager', 'Account Executive', 'Driver Coordinator', 'Operations Supervisor', 'Safety Manager', 'Dispatch Coordinator'};
String[] providerDepts = new String[]{'Operations', 'Sales', 'Distribution', 'Safety', 'Dispatch'};

for(Account acc : providerAccounts) {
    String companyDomain = acc.Name.toLowerCase().replace(' ', '').replace('-', '').replace('&', '').replace('.', '') + '.com';
    
    // Management contacts
    allContacts.add(new Contact(
        AccountId = acc.Id,
        FirstName = firstNames[Math.mod(nameIndex++, firstNames.size())],
        LastName = getRandomLastName(),
        Email = 'manager@' + companyDomain,
        Phone = generatePhone(),
        Title = 'Distribution Manager',
        Department = 'Operations'
    ));
    
    allContacts.add(new Contact(
        AccountId = acc.Id,
        FirstName = firstNames[Math.mod(nameIndex++, firstNames.size())],
        LastName = getRandomLastName(),
        Email = 'sales@' + companyDomain,
        Phone = generatePhone(),
        Title = 'Account Executive',
        Department = 'Sales'
    ));
    
    // Driver/Operations contacts
    allContacts.add(new Contact(
        AccountId = acc.Id,
        FirstName = firstNames[Math.mod(nameIndex++, firstNames.size())],
        LastName = getRandomLastName(),
        Email = 'dispatch@' + companyDomain,
        Phone = generatePhone(),
        Title = 'Driver Coordinator',
        Department = 'Operations'
    ));
    
    // Additional contacts for larger providers
    if(Math.mod(nameIndex, 3) != 0) {
        allContacts.add(new Contact(
            AccountId = acc.Id,
            FirstName = firstNames[Math.mod(nameIndex++, firstNames.size())],
            LastName = getRandomLastName(),
            Email = 'safety@' + companyDomain,
            Phone = generatePhone(),
            Title = 'Safety Manager',
            Department = 'Safety'
        ));
    }
}

insert allContacts;

System.debug('🎉 Step 2 Complete!');
System.debug('Total Contacts Created: ' + allContacts.size());
System.debug('Ready for Step 3: Locations');

// Helper methods
public static String getRandomLastName() {
    String[] lastNames = new String[]{'Rodriguez', 'Chen', 'Thompson', 'Williams', 'Anderson', 'Martinez', 'Johnson', 'Brown', 'Davis', 'Miller', 'Wilson', 'Moore', 'Taylor', 'Garcia', 'Lee', 'Harris', 'Clark', 'Lewis', 'Walker', 'Hall'};
    return lastNames[Math.mod(Math.abs(Crypto.getRandomInteger()), lastNames.size())];
}

public static String generatePhone() {
    String[] areaCodes = new String[]{'202', '301', '703', '240', '571'};
    String areaCode = areaCodes[Math.mod(Math.abs(Crypto.getRandomInteger()), areaCodes.size())];
    Integer exchange = 555;
    Integer numberPart = 1000 + Math.mod(Math.abs(Crypto.getRandomInteger()), 8999);
    return '(' + areaCode + ') ' + exchange + '-' + String.valueOf(numberPart).leftPad(4, '0');
}