#
# Cookbook:: win_choco
# Recipe:: default
#
# Copyright:: 2021, Progress
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

chocolatey_package 'git' do
  action :install
end

chocolatey_package '7zip.install' do
  action :install
end

chocolatey_package 'microsoft-edge' do
  action :install
end

chocolatey_package 'vscode' if node.exist?('software', 'vscode') do
  action :install
end

# Install Adobe Acrobat Reader if the Attribute [software][adobereader] exists. This can exist in a policyfile, role, or node level.
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

# Install for NodeJS based on a TAG

if tagged?('choco_nodejs')
  chocolatey_package 'nodejs' do
    action :install
  end
elsif node.exist?('packages', 'Node.js')
  chocolatey_package 'nodejs' do
    action :remove
  end
end
