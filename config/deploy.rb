set :application, "arux.net"

set :deploy_to, "/home/arux"

set :repository, "output/"
set :scm, :none
set :deploy_via, :copy

set :use_sudo, false

role :app, "arux@arux.net"
role :web, "arux@arux.net"
role :db,  "arux@arux.net", :primary => true