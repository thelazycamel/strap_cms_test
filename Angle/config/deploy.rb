DEPLOY_SETTINGS = YAML.load_file("#{File.dirname(__FILE__)}/deploy/#{ARGV[0]}.yml")

set :application, DEPLOY_SETTINGS["app_name"]
set :scm, DEPLOY_SETTINGS["scm"]
set :repo_url, DEPLOY_SETTINGS["repo_url"]
set :branch, ENV["BRANCH"] || DEPLOY_SETTINGS["default_branch"]
set :deploy_to, DEPLOY_SETTINGS["deploy_to"]
set :format, :pretty
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system}
set :default_env, { 'TERM' => "xterm" } # Solves issue with CentOS
set :keep_releases, 5
set :pty, true
set :bundle_without, %w{development test}.join(' ')

set :ssh_options, {
  keys: [ DEPLOY_SETTINGS["ssh_key"] || "#{ENV['HOME']}/.ssh/id_rsa" ]
}

role :app, DEPLOY_SETTINGS["web_servers"]
role :web, DEPLOY_SETTINGS["web_servers"]
role :db, DEPLOY_SETTINGS["web_servers"][0]

after "deploy:finishing", "deploy:cleanup"
after "deploy:finishing", "deploy:restart"