class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.env[:email_username]
  layout 'mailer'
end
