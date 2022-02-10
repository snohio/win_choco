# win_choco CHANGELOG

This file is used to list changes made in each version of the win_choco cookbook.

## 0.1.5

- Added NodeJS
- Added Adobe Acrobat Reader
- Added VSCode if Node Attribute

## 0.1.3

- Installs and Validates *Microsoft Edge*

## 0.1.2

- Updated Kitchen.yml to use latest Chef Client that allows for Compliance Phase when running -z
- Fixed Compliance Profile to send to chef-server-automate (and CLI)
- The Compliance phase requires Client 17 (metadata.rb)

## 0.1.0

Initial release.

- Installs Choco
- Installs Git
- Compliance Profile is built in.

The check sometimes needs to run twice because the path does not get updated during the run to be able to run the choco list commands.
