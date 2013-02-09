Vagrant::Config.run do |config|



  # LOAD BALANCER

  config.vm.define :lb do |config|
    
    config.vm.box = "precise64"
    config.vm.host_name = "lb.local"
    config.vm.network :hostonly, "33.33.33.30"
    config.vm.forward_port(80,3030)

    config.vm.provision :puppet, :module_path => "puppet/modules" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "default.pp"
    end

  end


  
  



end