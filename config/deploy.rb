set :application, "donaldplummer.com"

set :deploy_to, "/home/donaldplummer"

set :repository, "output/"
set :scm, :none
set :deploy_via, :copy

set :use_sudo, false

role :app, "donaldplummer@arux.net"
role :web, "donaldplummer@arux.net"
role :db,  "donaldplummer@arux.net", :primary => true