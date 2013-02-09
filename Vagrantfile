Vagrant::Config.run do |config|


  # LOAD BALANCER
  # --------------------------------------

  config.vm.define :lb do |config|
    
    config.vm.box = "precise64"
    #config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    
    config.vm.host_name = "lb.local"
    config.vm.network :hostonly, "33.33.33.30"
    config.vm.forward_port(80,3030)

    # Set the Timezone to something useful
    # config.vm.provision :shell, :inline => "echo \"Europe/London\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
    
    # Update the server
    config.vm.provision :shell, :inline => "apt-get update --fix-missing"

   
    config.vm.provision :puppet, :module_path => "puppet/modules" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "default.pp"
    end

  end


  
  



end