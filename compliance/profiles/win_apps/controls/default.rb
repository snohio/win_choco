# copyright: 2021, Mike Butler

control 'win-app' do
  impact 0.7
  title 'Windows Applications Installed'

  describe chocolatey_package('chocolatey') do
    it { should be_installed }
    its('version') { should cmp >= '1.2.1' }
  end

  describe chocolatey_package('7zip.install') do
    it { should be_installed }
    its('version') { should cmp >= '22.1' }
  end

  describe chocolatey_package('microsoft-edge') do
    it { should be_installed }
    its('version') { should cmp >= '110.0.1587.41' }
  end
end

control 'win-vscode' do
  impact 0.3
  title 'VS Code Installed'
  describe chocolatey_package('vscode') do
    it { should be_installed }
    its('version') { should cmp >= '1.75.0' }
  end
end if package('Microsoft Visual Studio Code').installed?

control 'win-adobe_reader' do
  impact 0.3
  title 'Adobe Reader Installed'
  describe chocolatey_package('adobereader') do
    it { should be_installed }
    its('version') { should cmp >= '2022.003.20314' }
  end
end if package('Adobe Acrobat Reader DC MUI').installed?

control 'win-nodejs' do
  impact 0.3
  title 'Node JS Installed'
  describe chocolatey_package('nodejs') do
    it { should be_installed }
    its('version') { should cmp >= '19.6.0' }
  end
end if package('Node.js').installed?

control 'win-openjdk' do
  impact 0.3
  title 'OpenJDK Installed'
  describe chocolatey_package('openjdk') do
    it { should be_installed }
    its('version') { should cmp >= '19.0.0' }
  end
end if ::Dir.exist?('C:\Program Files\OpenJDK')

control 'chef-developer' do
  impact 0.3
  title 'Chef Development Tools'
  describe chocolatey_package('chef-workstation') do
    it { should be_installed }
    its('version') { should cmp >= '23.2.1028' }
  end
  describe chocolatey_package('vscode') do
    it { should be_installed }
    its('version') { should cmp >= '1.75.1' }
  end
  describe chocolatey_package('git') do
    it { should be_installed }
    its('version') { should cmp >= '2.39.1' }
  end
end if ::Dir.exist?('C:\Chef')
