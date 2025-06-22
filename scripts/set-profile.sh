#!/bin/bash

# Set FuelBidder as default app for System Administrator profile
# Run from anywhere in the git repository

echo "Setting FuelBidder as default app via CLI..."

REPO_ROOT="$(git rev-parse --show-toplevel)"

# First, retrieve the System Administrator profile
echo "Retrieving System Administrator profile..."
sf project retrieve start --metadata Profile:"System Administrator"

# Check if profile was retrieved
PROFILE_PATH="${REPO_ROOT}/force-app/main/default/profiles/System Administrator.profile-meta.xml"

if [ ! -f "$PROFILE_PATH" ]; then
    echo "Profile not found at expected path. Let's check what was retrieved..."
    find "${REPO_ROOT}" -name "*.profile-meta.xml" -type f
    echo ""
    echo "If no profile files found, you may need to retrieve with:"
    echo "sf project retrieve start --metadata Profile"
    echo "Then manually identify your profile name."
    exit 1
fi

echo "Profile retrieved successfully!"
echo "Updating default app setting..."

# Create a script to update the profile XML
cat > "${REPO_ROOT}/update_profile_app.py" << 'EOF'
#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import sys
import os

def update_profile_default_app(profile_path):
    # Parse the XML
    tree = ET.parse(profile_path)
    root = tree.getroot()

    # Define namespace
    ns = {'sf': 'http://soap.sforce.com/2006/04/metadata'}

    # Find or create defaultApplication element
    default_app = root.find('sf:defaultApplication', ns)
    if default_app is not None:
        default_app.text = 'FuelBidder'
        print("Updated existing defaultApplication to FuelBidder")
    else:
        # Create new defaultApplication element
        default_app = ET.SubElement(root, '{http://soap.sforce.com/2006/04/metadata}defaultApplication')
        default_app.text = 'FuelBidder'
        print("Added new defaultApplication element set to FuelBidder")

    # Write back to file
    tree.write(profile_path, encoding='utf-8', xml_declaration=True)
    print(f"Profile updated: {profile_path}")

if __name__ == "__main__":
    repo_root = os.environ.get('REPO_ROOT', '.')
    profile_path = os.path.join(repo_root, 'force-app/main/default/profiles/System Administrator.profile-meta.xml')

    if os.path.exists(profile_path):
        update_profile_default_app(profile_path)
    else:
        print(f"Profile file not found: {profile_path}")
        sys.exit(1)
EOF

# Make the Python script executable
chmod +x "${REPO_ROOT}/update_profile_app.py"

# Run the Python script to update the profile
export REPO_ROOT="$REPO_ROOT"
python3 "${REPO_ROOT}/update_profile_app.py"

# Clean up the Python script
rm "${REPO_ROOT}/update_profile_app.py"

echo ""
echo "Profile updated! Now deploying..."
echo ""

# Deploy the updated profile
sf project deploy start --source-dir force-app/main/default/profiles

echo ""
echo "✅ FuelBidder app is now set as default!"
echo ""
echo "Complete deployment sequence:"
echo "1. Deploy tabs: sf project deploy start --source-dir force-app/main/default/tabs"
echo "2. Deploy app: sf project deploy start --source-dir force-app/main/default/applications --source-dir force-app/main/default/flexipages"
echo "3. Deploy profile: sf project deploy start --source-dir force-app/main/default/profiles"
echo ""
echo "After deployment, when you refresh Salesforce, you'll automatically be in the FuelBidder app!"