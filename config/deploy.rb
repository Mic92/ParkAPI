set :application, "ParkAPI"

role :app, %w{parkendd.higgsboson.tk}

set :scm, "git"
set :repo_url, "https://github.com/offenesdresden/ParkAPI.git"
set :branch, "master"
set :deploy_to, "/home/#{fetch(:stage)}/ParkAPI"
set :deploy_via, :remote_cache
set :keep_releases, 10
set :tmp_dir, "/tmp/Parkendd-#{fetch(:stage)}"
set :linked_files, %w{config.ini}
set :linked_dirs, %w{log venv}
set :shared_venv, Proc.new { shared_path.join("venv") }
set :requirements, Proc.new { release_path.join("requirements.txt") }

SSHKit.config.default_env = { path: 'venv/bin:$PATH' }

namespace :deploy do
  desc "Restart parkendd application"
  task :restart do
    on roles(:app), in: :sequence do
      # see config/park-api@.service

      # add to /etc/sudoers
      #  production ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart park-api@production
      #  production ALL=(ALL) NOPASSWD: /usr/bin/systemctl stop park-api@production
      #  production ALL=(ALL) NOPASSWD: /usr/bin/systemctl start park-api@production
      #  production ALL=(ALL) NOPASSWD: /usr/bin/systemctl status park-api@production
      #  staging ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart park-api@staging
      #  staging ALL=(ALL) NOPASSWD: /usr/bin/systemctl stop park-api@staging
      #  staging ALL=(ALL) NOPASSWD: /usr/bin/systemctl start park-api@staging
      #  staging ALL=(ALL) NOPASSWD: /usr/bin/systemctl status park-api@staging
      execute :sudo, "/usr/bin/systemctl", "restart", "park-api@#{fetch(:stage)}"
    end
  end
  after :finishing, "deploy:cleanup"
  after :publishing, :restart
  before 'deploy:updated', 'virtualenv:update'
end
