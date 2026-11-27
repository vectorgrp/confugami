<img src="_doc/logos/confugami_logo.svg" alt="Confµgami Logo" width="200"/>

# Confµgami

**Configuration files your editor understands and your build checks.**

A definition (`.def.json5`) declares what a product may be configured with: the properties, their types, ranges, units and documentation.
Configuration files (`.cfg.json5`) are validated against it, completed and documented in the IDE, merged across the teams contributing to them.
One engine `cfu` serves the editor, the CLI, CI and AI agents.

* [What Confµgami Gives You](https://help.vector.com/confugami/user-manual/index.html#_what_conf%C2%B5gami_gives_you)
* [Compared with Other Configuration Formats](https://help.vector.com/confugami/user-manual/comparison/index.html)

The commandline tool is called `cfu`.

## Documentation

* [Confµgami Manual](https://help.vector.com/confugami/user-manual/index.html) - Configuration and definition development and usage
* [Confµgami Playground](https://help.vector.com/confugami/playground/) - Online playground with IDE

## Installation

To install the `cfu` binary only of the latest release into the current directory, execute the following:

Linux/macOS/WSL/Windows (bash):

```bash
curl -fsSL https://help.vector.com/confugami/install.sh | bash
```

Windows (PowerShell):

```powershell
irm https://help.vector.com/confugami/install.ps1 | iex
```

Both scripts take `--version <version>` to install a specific release and `--pin` to write a `.confu`
next to the binary that disables the auto update:

```bash
curl -fsSL https://help.vector.com/confugami/install.sh | bash -s -- --version 0.36.0 --pin
```

```powershell
& ([scriptblock]::Create((irm https://help.vector.com/confugami/install.ps1))) --version 0.36.0 --pin
```

An installed `cfu` checks for a newer release in the background on start and updates itself after the
command has finished. Disable it per call with `--no-auto-update`, per environment with
`CONFUGAMI_AUTO_UPDATE=false`, or per installation with `--pin` (see
[Automatic Updates](https://help.vector.com/confugami/user-manual/cli/automatic-updates.html)).

## Manual Download

The install scripts download the `cfu` archive from the public maven repository [veHub](https://packages.vehub.vector.com/maven/com/vector/confugami/cfu/maven-metadata.xml).
To download an archive manually, replace `<version>` with a release, for example `0.35.0`, in the link for your platform:

| Platform              | Archive                                                                                                                    |
|-----------------------|----------------------------------------------------------------------------------------------------------------------------|
| Windows               | `https://packages.vehub.vector.com/maven/com/vector/confugami/cfu/<version>/cfu-<version>-x86_64-pc-windows-msvc.zip`      |
| Linux                 | `https://packages.vehub.vector.com/maven/com/vector/confugami/cfu/<version>/cfu-<version>-x86_64-unknown-linux-gnu.tar.gz` |
| macOS (Apple silicon) | `https://packages.vehub.vector.com/maven/com/vector/confugami/cfu/<version>/cfu-<version>-aarch64-apple-darwin.tar.gz`     |
| macOS (Intel)         | `https://packages.vehub.vector.com/maven/com/vector/confugami/cfu/<version>/cfu-<version>-x86_64-apple-darwin.tar.gz`      |

Extract the `cfu` executable (`cfu.exe` on Windows) from the `confugami-<version>-<platform>` folder in the archive.

## Features

* **Validation**: Validates configuration files (`.cfg.json5`) against the definitions (`cfu cfg validate`).
* **Merge Export**: Exports configuration split across multiple files as a single merged file (`cfu cfg export-merged`).
* **Configuration Tree**: Prints the merged configuration as a tree with its values, their origin and the required properties nobody configured (`cfu cfg inspect`).
* **Code Generation**: Generates Rust and Python code bindings for the definition models (`cfu def generate`).
* **Formatting**: Formats `.cfg`, `.def` and `.confu` files recursively across a project (`cfu format`).
* **Definition List**: Lists the definition names to bind a configuration to, with their configuration file mode (`cfu def list`).
* **Definition Tree**: Prints the resolved definitions, with the type, range and default of every parameter (`cfu def inspect`).
* **Workspace Overview**: Shows the discovered workspace roots (and why each was chosen), the CfgSpaces, and the `.cfg`/`.def`/`.confu` folder tree (`cfu workspace list`).
* **Terminal UI**: Browses the workspace, its configurations, definitions and diagnostics interactively (`cfu tui`, the command of a bare `cfu`).
* **Support Package**: Bundles the workspace files and local logs into a zip for bug reports (`cfu support`).
* **LSP Server**: Provides real-time diagnostics and validation for configuration and definition files in editors like VSCode.
* **MCP Server**: Exposes the tooling to LLM agents over the Model Context Protocol, so they can author and validate definitions and configurations.
* **Schema Generation**: Generates JSON Schemas from `.def.json5` definitions.
* **HTTP Model Server**: Serves the definition and configuration models as JSON over HTTP with live-reload via Server-Sent Events (`cfu server`).

See the [Confµgami Manual](https://help.vector.com/confugami/user-manual/index.html) for the full feature reference.

## IDE

### VSCode

The project includes a VSCode extension that connects to the `Confµgami` LSP server.

* Install it from the Visual Studio Code Marketplace: open the **Extensions** sidebar and search for **Confugami**.
  Without a `cfu` on the machine, the extension downloads the latest release.

## Commandline Usage

The `cfu` CLI commands (validation, merged export, formatting, workspace inspection, schema generation) are documented in the
[CLI chapter of the Confµgami Manual](https://help.vector.com/confugami/user-manual/cli/index.html).
