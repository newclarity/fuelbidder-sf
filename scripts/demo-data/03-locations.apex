// FuelBidder Demo Data - Step 3: Locations  
// Creates locations for customer accounts created in Step 1

System.debug('🚀 Starting Step 3: Creating Locations...');

// Query customer accounts created in Step 1
List<Account> customerAccounts = [SELECT Id, Name FROM Account WHERE Type = 'Customer - Direct' ORDER BY Name];
System.debug('Found ' + customerAccounts.size() + ' customer accounts for locations');

List<Location__c> allLocations = new List<Location__c>();

// DC Area Street Names and Addresses for Realism
String[] dcStreets = new String[]{'Constitution Ave NW', 'Pennsylvania Ave NW', 'K Street NW', 'Connecticut Ave NW', 'Wisconsin Ave NW'};
String[] mdStreets = new String[]{'Rockville Pike', 'Georgia Ave', 'University Blvd', 'New Hampshire Ave', 'Baltimore Ave'};  
String[] vaStreets = new String[]{'Lee Highway', 'Wilson Blvd', 'Columbia Pike', 'Route 7', 'Fairfax County Pkwy'};

String[] dcCities = new String[]{'Washington'};
String[] mdCities = new String[]{'Bethesda', 'Rockville', 'Silver Spring', 'College Park', 'Laurel'};
String[] vaCities = new String[]{'Arlington', 'Fairfax', 'Reston', 'Alexandria', 'Tysons'};

Integer locationCounter = 1001;

// Create 1-2 locations per customer account
for(Account acc : customerAccounts) {
    // Primary location (always create)
    String state = getRandomState();
    String[] streets = getStreetsForState(state);
    String[] cities = getCitiesForState(state);
    String street = streets[Math.mod(Math.abs(Crypto.getRandomInteger()), streets.size())];
    String city = cities[Math.mod(Math.abs(Crypto.getRandomInteger()), cities.size())];
    String zip = getZipForState(state);
    
    allLocations.add(new Location__c(
        Name = acc.Name + ' - Main Site',
        Account__c = acc.Id,
        Street_Address__c = String.valueOf(locationCounter++) + ' ' + street,
        City__c = city,
        State__c = state,
        Zip_Code__c = zip
    ));
    
    // Secondary location (60% chance)
    if(Math.mod(Math.abs(Crypto.getRandomInteger()), 10) < 6) {
        state = getRandomState();
        streets = getStreetsForState(state);
        cities = getCitiesForState(state);
        street = streets[Math.mod(Math.abs(Crypto.getRandomInteger()), streets.size())];
        city = cities[Math.mod(Math.abs(Crypto.getRandomInteger()), cities.size())];
        zip = getZipForState(state);
        
        allLocations.add(new Location__c(
            Name = acc.Name + ' - Secondary Site',
            Account__c = acc.Id,
            Street_Address__c = String.valueOf(locationCounter++) + ' ' + street,
            City__c = city,
            State__c = state,
            Zip_Code__c = zip
        ));
    }
}

insert allLocations;

System.debug('🎉 Step 3 Complete!');
System.debug('Total Locations Created: ' + allLocations.size());
System.debug('Ready for Step 4: Tanks (to be created)');

// Helper methods for realistic DC metro addresses
public static String getRandomState() {
    String[] states = new String[]{'DC', 'MD', 'VA'};
    return states[Math.mod(Math.abs(Crypto.getRandomInteger()), states.size())];
}

public static String[] getStreetsForState(String state) {
    if(state == 'DC') return new String[]{'Constitution Ave NW', 'Pennsylvania Ave NW', 'K Street NW', 'Connecticut Ave NW', 'Wisconsin Ave NW'};
    if(state == 'MD') return new String[]{'Rockville Pike', 'Georgia Ave', 'University Blvd', 'New Hampshire Ave', 'Baltimore Ave'};
    if(state == 'VA') return new String[]{'Lee Highway', 'Wilson Blvd', 'Columbia Pike', 'Route 7', 'Fairfax County Pkwy'};
    return new String[]{'Main Street'};
}

public static String[] getCitiesForState(String state) {
    if(state == 'DC') return new String[]{'Washington'};
    if(state == 'MD') return new String[]{'Bethesda', 'Rockville', 'Silver Spring', 'College Park', 'Laurel'};
    if(state == 'VA') return new String[]{'Arlington', 'Fairfax', 'Reston', 'Alexandria', 'Tysons'};
    return new String[]{'Unknown'};
}

public static String getZipForState(String state) {
    if(state == 'DC') return '200' + String.valueOf(10 + Math.mod(Math.abs(Crypto.getRandomInteger()), 40)).leftPad(2, '0');
    if(state == 'MD') return '208' + String.valueOf(10 + Math.mod(Math.abs(Crypto.getRandomInteger()), 89)).leftPad(2, '0');
    if(state == 'VA') return '221' + String.valueOf(10 + Math.mod(Math.abs(Crypto.getRandomInteger()), 89)).leftPad(2, '0');
    return '20000';
}