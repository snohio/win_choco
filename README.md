# win_choco

## About This Cookbook

This cookbook was put together to test installing Chocolatey on Windows systems. It utilizes the Chocolatey install cookbook from the Chef Supermarket. This was also created to show examples of multiple ways to guard application installation using attributes,  

## Kitchen Testing

We are using the Policyfile model and integrated the `kitchen verify` Inspec tests into a Compliance Profile as a part of the cookbook (client 17). Notice that the test\integration\default test in the kitchen.yml file was updated to point to the same content. But interestingly, it happens on the client side as well at the end of the run. I have noticed that you might have to run a `kitchen converge` twice.

Notice the Attributes section in the `kitchen.yml` file as well. There are examples of how to include attributes (as if they were node attributes on the Chef Server) as well as tags. This is how you would replicate those Chef Server Node Attributes.

## Requirements

### Platforms

* Windows 10, 11
* Windows server 2012, 2016. 2019

### Chef

* Chef server 17+

### Dependent Cookbooks

The following cookbooks are required to include this cookbook.

* Chocolatey

## Issues

Issues and suggestions are welcome. https://github.com/snohio/win_choco/issues

## License & Authors

**Authors:** [Michael Butler](mailto:snohio@gmail.com) (@snohio)

**License:** 2022, Apache 2 - by Snohio

## Thanks for Watching

Feel free to give this a clone down and see how it does on your system. Drop on some issues if you have questions or enhancement suggestions.