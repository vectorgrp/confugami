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
* [Confµgami Playground](https://help.vector.com/confugami/playground) - Online playground with IDE

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

## Examples

You can find many configuration and definition examples in the `test/` directory.
The corresponding JSON schemas for these examples are generated in the `test/schemas/` directory by the test suite (`./cb test`).
You can use these examples as a reference for creating your own definitions and configurations.

## Commandline Usage

The `cfu` CLI commands (validation, merged export, formatting, workspace inspection, schema generation) are documented in the
[CLI chapter of the Confµgami Manual](https://help.vector.com/confugami/user-manual/cli/index.html).
