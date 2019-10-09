namespace :sidekiq do
  desc "TODO"
  task start: :environment do
    sh 'bundle exec sidekiq -C ./config/sidekiq.yml'
  end
end
