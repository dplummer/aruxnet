set :application, "arux.net"

set :deploy_to, "/home/arux"

# set :repository, "output/"
# set :scm, :none
# set :deploy_via, :copy
default_run_options[:pty] = true

set :repository,  "git@github.com:dplummer/aruxnet.git"
set :scm, "git"
#set :scm_passphrase, "p@ssw0rd" #This is your custom users password
set :user, "arux"
ssh_options[:forward_agent] = true
set :branch, "origin/master"



set :use_sudo, false

role :app, "arux@arux.net"
role :web, "arux@arux.net"
role :db,  "arux@arux.net", :primary => true