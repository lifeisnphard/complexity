#!/bin/bash
set -e

# -----------------------------------------------------------------------------
# Comet Extension Enabler (macOS Policy Method)
# -----------------------------------------------------------------------------
# This script enables extensions on perplexity.ai domains in the Comet browser
# by setting the standard Chromium ExtensionSettings policy.
#
# It applies the policy to the 'org.chromium.Chromium' domain, which Comet
# respects. This avoids the need for a custom shortcut/launcher.
# -----------------------------------------------------------------------------

echo "Applying ExtensionSettings policy for generic Chromium..."

# The policy value must be a JSON string.
# We use single quotes around the JSON string to avoid shell expansion.
EXTENSION_SETTINGS='{"*":{"runtime_allowed_hosts":["*://*.perplexity.ai"],"runtime_blocked_hosts":[]}}'

# Apply to org.chromium.Chromium domain using the defaults command.
# This writes to ~/Library/Preferences/org.chromium.Chromium.plist
defaults write org.chromium.Chromium ExtensionSettings "$EXTENSION_SETTINGS"

echo "✅ Policy applied successfully!"
echo "🔄 Please restart Comet browser for changes to take effect."
echo ""
echo "Note: This setting applies to the generic 'org.chromium.Chromium' domain."
echo "If you use other unbranded Chromium browsers, this policy will apply to them as well."
