#
# Cookbook:: diiv
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'chefspec'

describe 'win_choco::default' do
  context 'When all attributes are default, on Windows 2019' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'windows', version: '2019')
      runner.node.normal['tags'] = %w(chef_developer choco_openjdk)
      runner.default['audit']['compliance_phase'] = true
      runner.converge(described_recipe)
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
