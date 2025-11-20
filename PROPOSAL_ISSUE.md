# Proposal: New Mac Method to Enable Extensions in Comet

## Background
The current "old method" for enabling extensions in Comet on macOS involves a custom wrapper application (`Comet - CPLX.app`) that modifies the `Local State` file before every launch. This is cumbersome and requires users to use a specific shortcut.

The recommended Windows method (`comet-policy-patch-win.ps1`) takes a different approach: it sets the `ExtensionSettings` policy in the Windows Registry under `HKLM\SOFTWARE\Policies\Chromium`. This indicates that the Comet browser respects standard Chromium Enterprise policies.

## Analysis
Since Comet respects the `Chromium` policy domain on Windows, it is highly probable that it respects the `org.chromium.Chromium` preference domain on macOS. This domain allows setting policies that apply to all Chromium-based browsers that do not use a specific bundle ID or fallback to the generic one.

By setting the `ExtensionSettings` in the `org.chromium.Chromium` domain using `defaults`, we can whitelist the `perplexity.ai` domain for extensions without needing a custom launcher.

## Proposed Solution
We can use the native macOS `defaults` command to set the policy. This method is persistent (until manually removed) and works with the standard Comet application.

### Command
The following command sets the policy:

```bash
defaults write org.chromium.Chromium ExtensionSettings '{"*":{"runtime_allowed_hosts":["*://*.perplexity.ai"],"runtime_blocked_hosts":[]}}'
```

### Script
I propose adding a script `comet-policy-patch-macos.sh` to the repository (e.g., in `perplexity/extension/scripts/`) to automate this for users.

```bash
#!/bin/bash
set -e

echo "Applying ExtensionSettings policy for generic Chromium (which Comet respects)..."

# The policy value must be a JSON string.
# We use single quotes around the JSON string to avoid shell expansion.
EXTENSION_SETTINGS='{"*":{"runtime_allowed_hosts":["*://*.perplexity.ai"],"runtime_blocked_hosts":[]}}'

# Apply to org.chromium.Chromium domain
defaults write org.chromium.Chromium ExtensionSettings "$EXTENSION_SETTINGS"

echo "Policy applied to org.chromium.Chromium."
echo "Please restart Comet browser for changes to take effect."
```

## Implementation Plan
1. Create `perplexity/extension/scripts/comet-policy-patch-macos.sh`.
2. Update `perplexity/extension/docs/comet-enable-extensions.md` to include the new method.
