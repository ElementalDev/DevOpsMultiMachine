# Install required plugins
required_plugins = ["vagrant-hostsupdater"]
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

varobj = {
  DB_HOST: "192.168.100.150"
}

def create_env_var(obj)
  command = <<~HEREDOC
  HEREDOC
  obj.each do |key, value|
    command += <<~HEREDOC
      echo #{key}: #{value}
      export #{key}=#{value} >> ~/.bashrc
      source ~/.bashrc
    HEREDOC
  end
  command
end

Vagrant.configure("2") do |config|
  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network("private_network", ip: "192.168.10.100")
    app.hostsupdater.aliases = ["development.local"]
    app.vm.synced_folder("app", "/home/ubuntu/app")
    app.vm.provision("shell", path: "environment/app/provision.sh", privileged: false)
    app.vm.provision("shell", inline: create_env_var({DB_HOST: "192.168.100.150"}))
  end

  config.vm.define "db" do |database|
    database.vm.box = "ubuntu/xenial64"
    database.vm.network("private_network", ip: "192.168.10.150")
    database.hostsupdater.aliases = ["database.local"]
    database.vm.synced_folder("environment/db", "/home/ubuntu/environment")
    database.vm.provision("shell", path: "environment/db/provision.sh", privileged: false)
  end
end
