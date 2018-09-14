# Install required plugins
required_plugins = ["vagrant-hostsupdater"]
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

obj = {
  DB_HOST: "192.168.100.140"
}


def create_env_var(obj)
  string = <<~HEREDOC
  HEREDOC
  obj.each do |key, value|
    string += <<~HEREDOC
      echo #{key}: #{value}
      echo "export #{key}=#{value}" >> ~/.bashrc
    HEREDOC
  end
  string += <<~HEREDOC
    source ~/.bashrc
  HEREDOC
end

Vagrant.configure("2") do |config|
  config.vm.define "db" do |database|
    database.vm.box = "ubuntu/xenial64"
    database.vm.network("private_network", ip: "192.168.10.140")
    database.hostsupdater.aliases = ["database.local"]
    database.vm.synced_folder("environment/db", "/home/ubuntu/environment")
    database.vm.provision("shell", path: "environment/db/provision.sh", privileged: false)
  end

  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network("private_network", ip: "192.168.10.100")
    app.hostsupdater.aliases = ["development.local"]
    app.vm.synced_folder("app", "/home/ubuntu/app")
    app.vm.synced_folder("environment/app", "/home/ubuntu/environment")
    app.vm.provision("shell", inline: create_env_var(obj), privileged: false)
    app.vm.provision("shell", path: "environment/app/provision.sh", privileged: false)
  end
end
