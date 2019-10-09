namespace :redis do
  desc "TODO"
  task clear: :environment do
    sh 'redis-cli FLUSHALL'
  end
end
