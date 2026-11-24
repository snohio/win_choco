#
# Cookbook:: win_choco
# Recipe:: default

include_profile 'win_choco::win_apps'

chocolatey_installer 'latest' do
  action :install
end

win_choco_package '7zip.install' do
  action :install
  update true
end

if tagged?('chrome')
  win_choco_package 'GoogleChrome' do
    action :install
    update true
  end
end

## Only install Microsoft Edge with Choco if it is not already a part of the OS install

win_choco_package 'microsoft-edge' do
  action :install
  update true
  not_if { node['packages']['Microsoft Edge'] }
end

# This is the Chef Developer Package
# If this is a Chef Developer's workstation, please include the tag chef_developer

if tagged?('chef_developer')
  win_choco_package 'chef-workstation' do
    action :install
    update true
  end
  win_choco_package 'vscode' do
    action :install
    update true
  end
  win_choco_package 'git' do
    action :install
    update true
  end
end

# Install Adobe Acrobat Reader if the Attribute [software][adobereader] exists.
# This can exist in a policyfile, role, or node level.

if node.exist?('software', 'adobereader')
  win_choco_package 'adobereader' do
    action :install
    update true
  end
# Remove it if it doesn't exist.
elsif node.exist?('packages', 'Adobe Acrobat Reader DC MUI')
  chocolatey_package 'adobereader' do
    action :remove
  end
end

# Install for NodeJS based on a TAG. Some Chocolatey installs
# have a .install piece too, so you need to remove both as below.

if tagged?('choco_nodejs')
  win_choco_package 'nodejs' do
    action :install
    update true
  end
  win_choco_package 'nodejs.install' do
    action :install
    update true
  end
elsif node.exist?('packages', 'Node.js')
  chocolatey_package 'nodejs' do
    action :remove
  end
  chocolatey_package 'nodejs.install' do
    action :remove
  end
end

if tagged?('choco_openjdk')
  win_choco_package 'openjdk' do
    action :install
    update true
  end
elsif node.exist?('packages', 'openjdk')
  chocolatey_package 'openjdk' do
    action :remove
  end
end
