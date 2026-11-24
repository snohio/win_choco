# win_choco

## About This Cookbook

This cookbook installs Chocolatey and packages on Windows using Chef's built-in Chocolatey resources. It also shows examples of guarding application installation using attributes.

## Package resource

`win_choco_package` checks Chocolatey's local package list before installing.
By default, an installed package is left unchanged. Set `update true` to
check for newer versions and upgrade an outdated, unpinned package:

```ruby
win_choco_package '7zip.install' do
  update true
end
```

The package name must be the Chocolatey package ID, not the Windows display
name. Updates use Chocolatey's configured sources and respect package pins.
The default recipe leaves updates disabled and retains its existing removal
and Microsoft Edge guards.

## Kitchen Testing

We are using the Policyfile model and integrated the `kitchen verify` Inspec tests into a Compliance Profile as a part of the cookbook (client 17). Notice that the test\integration\default test in the kitchen.yml file was updated to point to the same content. But interestingly, it happens on the client side as well at the end of the run. I have noticed that you might have to run a `kitchen converge` twice.

Notice the Attributes section in the `kitchen.yml` file as well. There are examples of how to include attributes (as if they were node attributes on the Chef Server) as well as tags. This is how you would replicate those Chef Server Node Attributes.

> If you add and then remove attributes in the kitchen.yml file, you will need to remove the .json file on the guest (test vm) located in `c:\Users\vagrant\AppData\Local\kitchen\node\` and then next run all of the attributes will be regathered. This is moderately an anti-pattern to Kitchen testing, but if you want to test what happens when an application is added or removed - triggered by an attribute / tag, that is the only way.

## Requirements

### Platforms

* Windows 10, 11
* Windows server 2012, 2016. 2019

### Chef

* Chef server 17+

## Issues

Issues and suggestions are welcome. [Win Choco on Github](https://github.com/snohio/win_choco/issues)

## License & Authors

*Authors:* [Michael Butler](mailto:snohio@gmail.com) (@snohio)

*License:* 2022, Apache 2 - by Snohio

## Thanks for Watching

Feel free to give this a clone down and see how it does on your system. Drop on some issues if you have questions or enhancement suggestions.
