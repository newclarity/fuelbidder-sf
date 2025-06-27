# FuelBidder - Salesforce DX Project

## Project Overview
A Salesforce application for managing fuel delivery operations, including drivers, providers, customers, and fuel orders with IoT integration capabilities.

## Architecture
- **Platform**: Salesforce DX
- **Custom Objects**: Driver__c, Fuel_Order__c, Fuel_Order_Item__c, Location__c, Provider__c, Tank__c
- **Account Types**: Customer, Provider, Vendor, Other record types
- **Features**: IoT device integration, GPS tracking, delivery management

## Development Commands
```bash
# Linting
npm run lint

# Testing
npm run test
npm run test:unit:watch
npm run test:unit:coverage

# Code Formatting
npm run prettier
npm run prettier:verify

# Deployment Scripts
./scripts/make-app.sh
./scripts/make-demo-data.sh
./scripts/insert-data.sh
```

## File Structure
- `force-app/main/default/` - Salesforce metadata
- `scripts/` - Deployment and data management scripts
- `sample_data/` - CSV files for testing
- `config/` - Project configuration

## Key Features
- Multi-tenant fuel delivery management
- Driver assignment and tracking
- IoT-enabled tank monitoring
- GPS-based delivery coordination
- Safety and compliance tracking