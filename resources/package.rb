unified_mode true

property :package_name, String, name_property: true
property :update, [true, false], default: false

action :install do
  if !chocolatey_installed?(new_resource.package_name)
    chocolatey_package new_resource.package_name do
      action :install
    end
  elsif new_resource.update && chocolatey_outdated?(new_resource.package_name)
    chocolatey_package new_resource.package_name do
      action :upgrade
    end
  end
end

action_class do
  def chocolatey_executable
    root = ENV['ChocolateyInstall'] || ::File.join(ENV.fetch('ProgramData', 'C:\ProgramData'), 'chocolatey')
    ::File.join(root, 'bin', 'choco.exe')
  end

  def chocolatey_installed?(package)
    version = shell_out!(chocolatey_executable, '--version').stdout.strip
    raise "Unexpected Chocolatey version: #{version.inspect}" unless version.match?(/\A\d+\./)

    args = ['list', '--limit-output']
    args << '--local-only' if version.to_i < 2
    result = shell_out!(chocolatey_executable, *args, returns: [0, 2])
    chocolatey_records(result.stdout, 2).any? { |record| record.first.casecmp?(package) }
  end

  def chocolatey_outdated?(package)
    result = shell_out!(chocolatey_executable, 'outdated', '--limit-output', returns: [0, 2])
    chocolatey_records(result.stdout, 4).any? do |record|
      unless %w(true false).include?(record[3].downcase)
        raise "Unexpected Chocolatey pinned status: #{record[3].inspect}"
      end
      record.first.casecmp?(package) && record[3].casecmp?('false')
    end
  end

  def chocolatey_records(output, fields)
    output.lines.reject { |line| line.strip.empty? }.map do |line|
      record = line.strip.split('|', -1)
      unless record.length == fields && record.none?(&:empty?)
        raise "Unexpected Chocolatey output: #{line.strip.inspect}"
      end
      record
    end
  end
end
