Vagrant Multi VM Environment (Ubuntu 12.04 LTS)
===============================================

This code provides VagrantFile + Puppet manifest scripts, which will create a standalone web prod environment, consisting of multi VMs, within your local development environment.

 - <a href="https://github.com/modernfidelity/vagrant-web-prod-lucid64">Click here for a complete version running Ubuntu 10.04 LTS</a>


Instructions
------------

- Make sure you have installed the Vagrant software : http://www.vagrantup.com/

 - Download links are here -> http://downloads.vagrantup.com/
 - For Windows users; at the time of writing this worked -> http://zamboni.readthedocs.org/en/latest/topics/install-zamboni/vagrant-on-windows.html

- Clone this repo and cd into the directory. 

- Run the following command : 


```bash
vagrant up
```

Machines
--------

This will then build the following vm boxes : 

- <strong>Load Balancer { varnish, niginx}</strong>
  - *33.33.33.30 (port forward 3030)*  
- <strong>2x Web { php, apache}</strong>
    - *33.33.33.31 (port forward 3031)*
    - *33.33.33.32 (port forward 3032)* 
- <strong>Database { MySQL }</strong>
    - *33.33.33.33 (port forward 3033)*


These VMs are based on Ubuntu Precise 64 Bit => http://files.vagrantup.com/precise64.box

Notes
-----
*Please note - you might get port errors if you are running other services on those ports. 

If this does occur you will need to either change your current service running on that specific port to another 
or amend the VagrantFile config file...
