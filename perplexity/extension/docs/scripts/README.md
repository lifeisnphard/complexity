# Comet Browser Scripts

This directory contains scripts to enable Complexity extension support in the Comet browser.

## comet-policy-patch-macos.sh

A LaunchAgent-based installer for macOS that automatically patches Comet to allow extensions on perplexity.ai domains.

### Features

- No custom shortcut required - launch Comet normally
- Runs automatically in the background via LaunchAgent
- Monitors and patches the Local State file when Comet modifies it
- No admin privileges required
- Includes uninstaller script

### Usage

Run in Terminal:

```bash
curl -fsSL "https://raw.githubusercontent.com/lifeisnphard/complexity/nxt/perplexity/extension/docs/scripts/comet-policy-patch-macos.sh" | bash
```

After installation:

- Restart the browser or log out/in
- Launch Comet normally (no custom shortcut needed)
- Extensions will work on perplexity.ai domains

### How It Works

1. Creates a LaunchAgent at `~/Library/LaunchAgents/app.cplx.comet-policy-patcher.plist`
2. Installs a patcher script at `~/Library/Application Support/Complexity/comet-patcher.sh`
3. Monitors `~/Library/Application Support/Comet/Local State` for changes
4. When Comet sets `Allow-external-extensions-scripting-on-NTP` to `false`, patches it back to `true`
5. Next Comet launch reads `true` value, allowing extensions to work

### Uninstall

Run:

```bash
bash ~/Library/Application\ Support/Complexity/uninstall-comet-patcher.sh
```

### Logs

Logs are written to: `~/Library/Logs/Comet-Policy-Patcher.log`

## Background

See the [article](../articles/comet-enable-extensions-article.md) for technical details on why this is necessary and how the workaround was discovered.
