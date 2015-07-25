namespace :virtualenv do
  task :create do
    venv = fetch(:shared_venv)
    execute :mkdir, '-p', File.dirname(venv)
    unless test "[ -d #{venv} ]"
      execute :virtualenv, venv
    end
  end

  task :pip do
    with rack_env: :test do
      within(release_path) do
        execute "venv/bin/pip", "install", "-e", ".", "-r", fetch(:requirements)
      end
    end
  end

  task :relocate do
    venv = fetch(:shared_venv)
    execute :virtualenv, "--relocatable", venv
    execute :cp, "-RPp", venv, File.join(fetch(:release_path), "venv")
  end

  task :update do
    on roles(:app) do
      invoke :create
      invoke :pip
      invoke :relocate
    end
  end
end
