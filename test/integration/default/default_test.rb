# Chef InSpec test for recipe win_choco::default

# Chocolatey Should Exist
describe chocolatey_package('chocolatey') do
  it { should be_installed }
  its('version') { should cmp > '0.11' }
end

describe chocolatey_package('git') do
  it { should be_installed }
  its('version') { should cmp > '2.33.0' }
end
