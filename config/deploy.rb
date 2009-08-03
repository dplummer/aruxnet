set :application, "arux.net"

set :deploy_to, "/home/arux"

set :repository, "output/"
set :scm, :none
set :deploy_via, :copy
#default_run_options[:pty] = true

# set :repository,  "git@github.com:dplummer/aruxnet.git"
# set :scm, "git"
#set :scm_passphrase, "p@ssw0rd" #This is your custom users password
# set :user, "arux"
# ssh_options[:forward_agent] = true
# set :branch, "master"



set :use_sudo, false

role :app, "arux@arux.net"
role :web, "arux@arux.net"
role :db,  "arux@arux.net", :primary => true



namespace(:customs) do
  task :symlink, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/long-term #{release_path}/long-term ;
      ln -nfs #{shared_path}/cards #{release_path}/images/cards ;
    CMD
  end
end

after "deploy:symlink","customs:symlink"
after "deploy", "deploy:cleanup"
