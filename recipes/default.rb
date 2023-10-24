#
# Cookbook:: win_choco
# Recipe:: default
#
# Copyright:: 2023, Progress
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_profile 'win_choco::win_apps'

include_recipe 'chocolatey::default'

chocolatey_package '7zip.install' do
  action :install
end

if tagged?('chrome')
  chocolatey_package 'GoogleChrome' do
    action :install
  end
end

## Only install Microsoft Edge with Choco if it is not already a part of the OS install

chocolatey_package 'microsoft-edge' do
  action :install
  not_if { node['packages']['Microsoft Edge'] }
end

# This is the Chef Developer Package
# If this is a Chef Developer's workstation, please include the tag chef_developer

if tagged?('chef_developer')
  chocolatey_package 'chef-workstation' do
    action :install
  end
  chocolatey_package 'vscode' do
    action :install
  end
  chocolatey_package 'git' do
    action :install
  end
end

# Install Adobe Acrobat Reader if the Attribute [software][adobereader] exists.
# This can exist in a policyfile, role, or node level.

if node.exist?('software', 'adobereader')
  chocolatey_package 'adobereader' do
    action :install
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
  chocolatey_package 'nodejs' do
    action :install
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
  chocolatey_package 'openjdk' do
    action :install
  end
elsif node.exist?('packages', 'openjdk')
  chocolatey_package 'openjdk' do
    action :remove
  end
end
