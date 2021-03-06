Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = true

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.assets.debug = true

  config.assets.quiet = true

  # config.action_view.raise_on_missing_translations = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.active_job.queue_adapter     = :sidekiq
  config.active_job.queue_name_prefix = ENV['QUEUE_NAME_PREFIX']

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.deliver_later_queue_name = ENV['EMAIL_QUEUE_NAME']
  config.action_mailer.default_url_options = {
    host: ENV['EMAIL_HOST'],
    protocol: ENV['PROTOCOL'],
  }
  ActionMailer::Base.smtp_settings = {
    :address        => ENV['EMAIL_DOMAIN'],
    :port           => ENV['EMAIL_PORT'],
    :authentication => :plain,
    :user_name      => ENV['EMAIL_USERNAME'],
    :password       => ENV['EMAIL_PASSWORD'],
    # :enable_starttls_auto => true
  }
end
