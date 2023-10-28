# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# This is the default from address for all emails sent from the application.
ActionMailer::Base.default :from => "HillwoodEmpire <hillwoodempire@gmail.com>"
