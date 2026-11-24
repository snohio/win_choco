require 'spec_helper'

describe 'win_choco_package' do
  platform 'windows', '2019'
  step_into :win_choco_package

  let(:installed_output) { '' }
  let(:outdated_output) { '' }
  let(:choco_version) { '2.6.0' }
  let(:update_enabled) { false }

  recipe do
    win_choco_package '7zip.install' do
      update true if node['win_choco_test_update']
    end
  end

  before do
    chef_runner.node.normal['win_choco_test_update'] = update_enabled
    version = choco_version
    installed = installed_output
    outdated = outdated_output
    stubs_for_provider('win_choco_package[7zip.install]') do |provider|
      allow(provider).to receive(:chocolatey_executable).and_return('choco.exe')
      allow(provider).to receive(:shell_out!).with('choco.exe', '--version').and_return(double(stdout: version))
      list_args = ['choco.exe', 'list', '--limit-output']
      list_args << '--local-only' if version.to_i < 2
      allow(provider).to receive(:shell_out!).with(*list_args, returns: [0, 2]).and_return(double(stdout: installed))
      allow(provider).to receive(:shell_out!).with('choco.exe', 'outdated', '--limit-output', returns: [0, 2]).and_return(double(stdout: outdated))
    end
  end

  it 'installs a missing package' do
    expect(chef_run).to install_chocolatey_package('7zip.install')
  end

  context 'when updates are enabled and only a similarly named package exists' do
    let(:update_enabled) { true }
    let(:installed_output) { "7zip|1.0\n" }

    it 'installs the requested package' do
      expect(chef_run).to install_chocolatey_package('7zip.install')
    end
  end

  context 'when the package is installed' do
    let(:installed_output) { "7ZIP.INSTALL|1.0\n7zip|2.0\n" }

    it 'does not install or upgrade it by default' do
      expect(chef_run).not_to install_chocolatey_package('7zip.install')
      expect(chef_run).not_to upgrade_chocolatey_package('7zip.install')
    end

    context 'when updates are enabled' do
      let(:update_enabled) { true }

      it 'does nothing when the package is current' do
        expect(chef_run).not_to upgrade_chocolatey_package('7zip.install')
      end

      context 'when a different package is outdated' do
        let(:outdated_output) { "7zip|1.0|2.0|false\n" }

        it 'does not upgrade the requested package' do
          expect(chef_run).not_to upgrade_chocolatey_package('7zip.install')
        end
      end

      context 'when the package is outdated' do
        let(:outdated_output) { "7ZIP.INSTALL|1.0|2.0|false\n" }

        it 'upgrades the package' do
          expect(chef_run).to upgrade_chocolatey_package('7zip.install')
        end
      end

      context 'when the package is pinned' do
        let(:outdated_output) { "7zip.install|1.0|2.0|true\n" }

        it 'does not upgrade the package' do
          expect(chef_run).not_to upgrade_chocolatey_package('7zip.install')
        end
      end
    end
  end

  context 'with Chocolatey 1' do
    let(:choco_version) { '1.4.0' }
    let(:installed_output) { "7zip.install|1.0\n" }

    it 'queries the local list' do
      expect(chef_run).not_to install_chocolatey_package('7zip.install')
    end
  end

  context 'when the list output is malformed' do
    let(:installed_output) { 'unexpected output' }

    it 'fails rather than treating the package as absent' do
      expect { chef_run }.to raise_error(/Unexpected Chocolatey output/)
    end
  end
end
