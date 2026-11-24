#!/usr/bin/env bash
# Downloads the cfu binary of a Confµgami release from vehub into the current working directory.
set -euo pipefail

MAVEN_URL="https://packages.vehub.vector.com/maven/com/vector/confugami/cfu"

usage() {
    cat <<'USAGE'
Usage: install.sh [--version <version>] [--pin]

  --version <version>  Install this version instead of the latest release (with or without the leading 'v').
  --pin                Write a .confu next to the binary that disables the auto update.
USAGE
}

version=""
pin=0
while [ $# -gt 0 ]; do
    case "$1" in
        --version)
            version="${2:-}"
            [ -n "$version" ] || { echo "--version needs a value." >&2; exit 1; }
            shift 2
            ;;
        --pin) pin=1; shift ;;
        -h | --help) usage; exit 0 ;;
        *) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
    esac
done

case "$(uname -s)" in
    Linux*) target="x86_64-unknown-linux-gnu" ;;
    Darwin*)
        case "$(uname -m)" in
            arm64 | aarch64) target="aarch64-apple-darwin" ;;
            *) target="x86_64-apple-darwin" ;;
        esac
        ;;
    MINGW* | MSYS* | CYGWIN*) target="x86_64-pc-windows-msvc" ;;
    *) echo "Unsupported platform: $(uname -s) $(uname -m)" >&2; exit 1 ;;
esac

if [ -z "$version" ]; then
    version="$(curl -fsSL "$MAVEN_URL/maven-metadata.xml" | sed -n 's:.*<release>\(.*\)</release>.*:\1:p')" || version=""
    [ -n "$version" ] || { echo "Could not resolve the latest release, pass --version." >&2; exit 1; }
fi
version="${version#v}"

case "$target" in
    *windows*) ext="zip"; bin="cfu.exe" ;;
    *) ext="tar.gz"; bin="cfu" ;;
esac
dist="confugami-$version-$target"

# A relative temp dir, because a native Windows curl/tar in a bash on Windows cannot write to an
# absolute POSIX path like /tmp/... (curl error 23) when the shell does not translate the argument.
tmp="$(mktemp -d ./.cfu-install-XXXXXX)"
trap 'rm -rf "$tmp"' EXIT

url="$MAVEN_URL/$version/cfu-$version-$target.$ext"
echo "Downloading cfu-$version-$target.$ext"
# Without the guard the script would exit with curl's own status (22 on a 404).
curl -fsSL -o "$tmp/asset" "$url" || { echo "Download failed: $url" >&2; exit 1; }

# Git for Windows ships GNU tar, which cannot read a zip, so unzip wins when present.
if [ "$ext" = "zip" ] && command -v unzip > /dev/null 2>&1; then
    unzip -oj "$tmp/asset" "$dist/$bin" -d .
else
    tar -xf "$tmp/asset" -C . --strip-components=1 "$dist/$bin"
fi

if [ "$pin" = 1 ]; then
    if [ -e .confu ]; then
        echo "Warning: .confu exists, left untouched. Add 'executableSettings: { autoUpdate: false }' yourself." >&2
    else
        cat > .confu <<'CONFU'
{
  executableSettings: {
    autoUpdate: false,
  },
}
CONFU
        echo "Wrote .confu with autoUpdate disabled."
    fi
fi

echo "Installed $bin $version to $(pwd)"
