#!/usr/bin/env bash

version=$1
if [[ -z "$version" ]]; then
    echo "You must supply a version number."
    exit 1
fi

# The single quotes around EOF is to stop attempted variable and backtick expansion.
read -r -d '' release_description << 'EOF'
Command line interface for authenticating with the SAFE Network.

With the SAFE authenticator, users can create SAFE Network accounts, log in using existing credentials (secret and password), authorise applications which need to store data on the network on behalf of the user, and manage permissions granted to applications.

## Development Builds

There are also development versions of this release:
[Linux](S3_LINUX_DEPLOY_URL)
[macOS](S3_MACOS_DEPLOY_URL)
[Windows](S3_WIN_DEPLOY_URL)

The development version uses a mocked SAFE network, allowing you to work against a file that mimics the network, where SafeCoins are created for local use.

## SHA-256 Checksums for Release Versions
```
Linux
zip: ZIP_LINUX_CHECKSUM
tar.gz: TAR_LINUX_CHECKSUM

macOS
zip: ZIP_MACOS_CHECKSUM
tar.gz: TAR_MACOS_CHECKSUM

Windows
zip: ZIP_WIN_CHECKSUM
tar.gz: TAR_WIN_CHECKSUM
```

## Related Links
* [SAFE CLI](https://github.com/maidsafe/safe-cli/releases/latest/)
* [SAFE Browser PoC](https://github.com/maidsafe/safe_browser/releases/)
* [SAFE Vault](https://github.com/maidsafe/safe_vault/releases/latest/)
EOF

safe_completion_url="https:\/\/github.com\/maidsafe\/safe-cli\/releases\/download\/$version\/safe_completion.sh"
s3_linux_deploy_url="https:\/\/safe-authenticator-cli.s3.amazonaws.com\/safe_authenticator_cli-$version-x86_64-unknown-linux-gnu-dev.zip"
s3_win_deploy_url="https:\/\/safe-authenticator-cli.s3.amazonaws.com\/safe_authenticator_cli-$version-x86_64-pc-windows-gnu-dev.zip"
s3_macos_deploy_url="https:\/\/safe-authenticator-cli.s3.amazonaws.com\/safe_authenticator_cli-$version-x86_64-apple-darwin-dev.zip"
zip_linux_checksum=$(sha256sum \
    "./deploy/release/safe_authenticator_cli-$version-x86_64-unknown-linux-gnu.zip" | \
    awk '{ print $1 }')
zip_macos_checksum=$(sha256sum \
    "./deploy/release/safe_authenticator_cli-$version-x86_64-apple-darwin.zip" | \
    awk '{ print $1 }')
zip_win_checksum=$(sha256sum \
    "./deploy/release/safe_authenticator_cli-$version-x86_64-pc-windows-gnu.zip" | \
    awk '{ print $1 }')
tar_linux_checksum=$(sha256sum \
    "./deploy/release/safe_authenticator_cli-$version-x86_64-unknown-linux-gnu.tar.gz" | \
    awk '{ print $1 }')
tar_macos_checksum=$(sha256sum \
    "./deploy/release/safe_authenticator_cli-$version-x86_64-apple-darwin.tar.gz" | \
    awk '{ print $1 }')
tar_win_checksum=$(sha256sum \
    "./deploy/release/safe_authenticator_cli-$version-x86_64-pc-windows-gnu.tar.gz" | \
    awk '{ print $1 }')

release_description=$(sed "s/S3_LINUX_DEPLOY_URL/$s3_linux_deploy_url/g" <<< "$release_description")
release_description=$(sed "s/S3_MACOS_DEPLOY_URL/$s3_macos_deploy_url/g" <<< "$release_description")
release_description=$(sed "s/S3_WIN_DEPLOY_URL/$s3_win_deploy_url/g" <<< "$release_description")
release_description=$(sed "s/SAFE_COMPLETION_URL/$safe_completion_url/g" <<< "$release_description")
release_description=$(sed "s/ZIP_LINUX_CHECKSUM/$zip_linux_checksum/g" <<< "$release_description")
release_description=$(sed "s/ZIP_MACOS_CHECKSUM/$zip_macos_checksum/g" <<< "$release_description")
release_description=$(sed "s/ZIP_WIN_CHECKSUM/$zip_win_checksum/g" <<< "$release_description")
release_description=$(sed "s/TAR_LINUX_CHECKSUM/$tar_linux_checksum/g" <<< "$release_description")
release_description=$(sed "s/TAR_MACOS_CHECKSUM/$tar_macos_checksum/g" <<< "$release_description")
release_description=$(sed "s/TAR_WIN_CHECKSUM/$tar_win_checksum/g" <<< "$release_description")
echo "$release_description"
