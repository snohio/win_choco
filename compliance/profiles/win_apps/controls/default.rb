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
end
