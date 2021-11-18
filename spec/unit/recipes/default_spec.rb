#
# Cookbook:: diiv
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'chefspec'

describe 'win_choco::default' do
  context 'When all attributes are default, on Windows 2016' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2016')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to raise_error
    end
  end
end
