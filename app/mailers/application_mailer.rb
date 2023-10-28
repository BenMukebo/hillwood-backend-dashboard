class ApplicationMailer < ActionMailer::Base
  default from: 'support@hillwoodempire.org',
          reply_to: 'l.benkasmukebo7@gmail.com'

  layout 'mailer'
end
