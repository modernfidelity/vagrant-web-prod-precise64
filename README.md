Vagrant Multi VM Environment
============================

This code provides VagrantFile + Puppet files for a standalone web prod environment, consisting of multi VMs.


Instructions
------------

Make sure you have installed the Vagrant software : http://www.vagrantup.com/

Clone this repo and cd into the directory. 

Run the following command : 


```bash
vagrant up
```

Machines
--------

This will then build the following vm boxes : 


 - Load Balancer { varnish, niginx}
 
   33.33.33.30 (port forward 3030)

 - 2x Web { php, apache}

   33.33.33.31 (port forward 3031)
   33.33.33.32 (port forward 3032)
  
 - Database { MySQL }

   33.33.33.33 (port forward 3033)


These VMs are based on Ubuntu Precise 64 Bit => http://files.vagrantup.com/precise64.box

Notes
-----
*Please note - you might get port errors if you are running other services on those ports. 

If this does occur you will need to either change your current service running on that port to another 
or amend the VagrantFile and amend the port to be used there...
