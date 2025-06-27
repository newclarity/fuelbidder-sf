# FuelBidder Salesforce Development Makefile
# Requires: Salesforce CLI, enabled DevHub

# Configuration
DEVHUB_ALIAS = DevHub
SCRATCH_ORG_ALIAS = fuelbidder-dev
SCRATCH_DAYS = 30
PROJECT_SCRATCH_DEF = config/project-scratch-def.json

# Default target
.DEFAULT_GOAL := help

# Help target - displays available commands
help:
	@echo "FuelBidder Salesforce Development Commands:"
	@echo ""
	@echo "Setup Commands:"
	@echo "  auth             - Authenticate to DevHub and create config"
	@echo "  setup-devhub     - Authenticate to DevHub org"
	@echo "  create-config    - Create scratch org definition file"
	@echo ""
	@echo "Scratch Org Commands:"
	@echo "  create-scratch   - Create new scratch org"
	@echo "  deploy           - Deploy code to scratch org"
	@echo "  assign-perms     - Assign all permission sets to user"
	@echo "  open             - Open scratch org in browser"
	@echo "  reset            - Delete current scratch org and create fresh one"
	@echo "  clean            - Delete scratch org"
	@echo ""
	@echo "Development Workflow:"
	@echo "  dev              - Create scratch org and deploy (one command setup)"
	@echo "  redeploy         - Deploy changes to existing scratch org"
	@echo ""
	@echo "Utility Commands:"
	@echo "  status           - Show current scratch org status"
	@echo "  list-orgs        - List all active scratch orgs"

# Setup Commands
setup-devhub:
	@echo "🔐 Authenticating to DevHub..."
	sf org login web --alias $(DEVHUB_ALIAS) --set-default-dev-hub

create-config:
	@echo "📝 Creating scratch org definition..."
	@mkdir -p config
	@echo '{\n  "orgName": "FuelBidder Dev Org",\n  "edition": "Developer",\n  "features": ["EnableSetPasswordInApi"],\n  "settings": {\n    "lightningExperienceSettings": {\n      "enableS1DesktopEnabled": true\n    }\n  }\n}' > $(PROJECT_SCRATCH_DEF)
	@sf config set org-capitalize-record-types false
	@echo "✅ Created $(PROJECT_SCRATCH_DEF)"

# Scratch Org Management
create-scratch:
	@echo "🚀 Creating scratch org '$(SCRATCH_ORG_ALIAS)'..."
	sf org create scratch --definition-file $(PROJECT_SCRATCH_DEF) --alias $(SCRATCH_ORG_ALIAS) --duration-days $(SCRATCH_DAYS) --set-default
	@echo "✅ Scratch org created successfully!"

deploy:
	@echo "📦 Deploying FuelBidder code to scratch org..."
	sf project deploy start --target-org $(SCRATCH_ORG_ALIAS) --ignore-conflicts
	@echo "✅ Deployment complete!"

assign-perms:
	@echo "🔐 Assigning permission sets..."
	-sf org assign permset --name FuelBidder_Tabs --target-org $(SCRATCH_ORG_ALIAS)
	-sf org assign permset --name FuelBidder_Admin --target-org $(SCRATCH_ORG_ALIAS)
	-sf org assign permset --name FuelBidder_Dispatcher --target-org $(SCRATCH_ORG_ALIAS)
	-sf org assign permset --name FuelBidder_Owner --target-org $(SCRATCH_ORG_ALIAS)
	-sf org assign permset --name FuelBidder_SalesRep --target-org $(SCRATCH_ORG_ALIAS)
	@echo "✅ Permission sets assigned!"

open:
	@echo "🌐 Opening scratch org in browser..."
	sf org open --target-org $(SCRATCH_ORG_ALIAS)

clean:
	@echo "🗑️  Deleting scratch org '$(SCRATCH_ORG_ALIAS)'..."
	-sf org delete scratch --target-org $(SCRATCH_ORG_ALIAS) --no-prompt
	@echo "✅ Scratch org deleted!"

reset: clean create-scratch deploy assign-perms
	@echo "🔄 Scratch org reset complete!"

# Development Workflow Commands
dev: create-scratch deploy assign-perms open
	@echo "🎉 Development environment ready!"

redeploy: deploy assign-perms
	@echo "🔄 Code redeployed!"

# Utility Commands
status:
	@echo "📊 Current scratch org status:"
	sf org display --target-org $(SCRATCH_ORG_ALIAS)

list-orgs:
	@echo "📋 Active scratch orgs:"
	sf org list

# Authentication setup - run once to get authenticated and configured
auth: setup-devhub create-config
	@echo ""
	@echo "🎉 Authentication and config setup complete!"
	@echo ""
	@echo "Next steps:"
	@echo "1. Enable DevHub in your Salesforce org (Setup → Dev Hub → Enable)"
	@echo "2. Run 'make dev' to create your first scratch org"

# Development cycle aliases for convenience
fresh: reset
new: create-scratch
up: deploy open

.PHONY: help auth setup-devhub create-config create-scratch deploy assign-perms open clean reset dev redeploy status list-orgs fresh new up