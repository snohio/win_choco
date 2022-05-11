# copyright: 2021, Mike Butler

control 'win-app' do
  impact 0.7
  title 'Windows Applications Installed'

  describe chocolatey_package('chocolatey') do
    it { should be_installed }
    its('version') { should cmp > '0.11' }
  end

  describe chocolatey_package('git') do
    it { should be_installed }
    its('version') { should cmp > '2.33.0' }
  end

  describe chocolatey_package('7zip.install') do
    it { should be_installed }
    its('version') { should cmp > '21.0' }
  end

  describe chocolatey_package('microsoft-edge') do
    it { should be_installed }
    its('version') { should cmp > '96.0' }
  end
end

control 'win-vscode' do
  impact 0.3
  title 'VS Code Installed'
  describe chocolatey_package('vscode') do
    it { should be_installed }
    its('version') { should cmp > '1.64.0' }
  end
  only_if { package('Microsoft Visual Studio Code').installed? }
end

control 'win-adobe_reader' do
  impact 0.3
  title 'Adobe Reader Installed'
  describe chocolatey_package('adobereader') do
    it { should be_installed }
    its('version') { should cmp > '2021.011.0' }
  end
  only_if { package('Adobe Acrobat Reader DC MUI').installed? }
end

control 'win-nodejs' do
  impact 0.3
  title 'Node JS Installed'
  describe chocolatey_package('nodejs') do
    it { should be_installed }
    its('version') { should cmp > '17.0.0' }
  end
  only_if { package('Node.js').installed? }
end

control 'win-openjdk' do
  impact 0.3
  title 'OpenJDK Installed'
  describe chocolatey_package('openjdk') do
    it { should be_installed }
    its('version') { should cmp > '18.0.0' }
  end
  only_if { package('OpenJava Development Kit').installed? }
end
