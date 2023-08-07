class ApplicationMailer < ActionMailer::Base
  default from: "noreply@postcrossing.local"
  layout "mailer"
end
