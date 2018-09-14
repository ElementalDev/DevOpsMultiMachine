# Install required plugins
required_plugins = ["vagrant-hostsupdater"]
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

def set_env vars
  # Creating a HEREDOC variable
  # This creates a single line out of what is within it to be able to run in Bash
  command = <<~HEREDOC
      echo "Setting Environment Variables"
      source ~/.bashrc
  HEREDOC
  # Go through the object and extract the key and value
  vars.each do |key, value|
    # If the string is more than 0, Then run the code
    command += <<~HEREDOC
      if [ -z "$#{key}" ]; then
          echo "export #{key}=#{value}" >> ~/.bashrc
      fi
    HEREDOC
  end
  # Return the command
  return command
end

Vagrant.configure("2") do |config|
  # Create the database machine
  config.vm.define "db" do |database|
    # Define the OS for the VM
    database.vm.box = "ubuntu/xenial64"
    # Define the network the VM will be using
    database.vm.network("private_network", ip: "192.168.10.150")
    # Give an Alias to the IP above
    database.hostsupdater.aliases = ["database.local"]
    # Create a synced folder from the computer to the VM
    database.vm.synced_folder("environment/db", "/home/ubuntu/environment")
    # Provision the VM shell
    database.vm.provision("shell", path: "environment/db/provision.sh", privileged: false)
  end

  # Create the app machine
  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network("private_network", ip: "192.168.10.100")
    app.hostsupdater.aliases = ["development.local"]
    app.vm.synced_folder("app", "/home/ubuntu/app")
    app.vm.synced_folder("environment/app", "/home/ubuntu/environment")
    # Inline provision the VM
    app.vm.provision "shell", inline: set_env({ DB_HOST: "mongodb://192.168.10.150:27017/posts" }), privileged: false
    app.vm.provision("shell", path: "environment/app/provision.sh", privileged: false)
  end
end
