# copyright: 2023, Mike Butler

control 'win-app' do
  impact 0.7
  title 'Windows Applications Installed'

  describe chocolatey_package('chocolatey') do
    it { should be_installed }
    its('version') { should cmp >= '2.6.0' }
  end

  describe chocolatey_package('7zip.install') do
    it { should be_installed }
    its('version') { should cmp >= '25.1.0' }
  end
end

control 'win-vscode' do
  impact 0.3
  title 'VS Code Installed'
  describe chocolatey_package('vscode') do
    it { should be_installed }
    its('version') { should cmp >= '1.108.0' }
  end
end if package('Microsoft Visual Studio Code').installed?

control 'win-adobe_reader' do
  impact 0.3
  title 'Adobe Reader Installed'
  describe chocolatey_package('adobereader') do
    it { should be_installed }
    its('version') { should cmp >= '2025.1.21111' }
  end
end if package('Adobe Acrobat Reader DC MUI').installed?

control 'win-nodejs' do
  impact 0.3
  title 'Node JS Installed'
  describe chocolatey_package('nodejs') do
    it { should be_installed }
    its('version') { should cmp >= '25.5.0' }
  end
end if package('Node.js').installed?

control 'win-openjdk' do
  impact 0.3
  title 'OpenJDK Installed'
  describe chocolatey_package('openjdk') do
    it { should be_installed }
    its('version') { should cmp >= '25.0.0' }
  end
end if ::Dir.exist?('C:\Program Files\OpenJDK')

control 'chef-developer' do
  impact 0.3
  title 'Chef Development Tools'
  describe chocolatey_package('chef-workstation') do
    it { should be_installed }
    its('version') { should cmp >= '25.12.1102' }
  end
  describe chocolatey_package('vscode') do
    it { should be_installed }
    its('version') { should cmp >= '1.108.0' }
  end
  describe chocolatey_package('git') do
    it { should be_installed }
    its('version') { should cmp >= '2.52.0' }
  end
end if ::Dir.exist?('C:\opscode\chef-workstation')
