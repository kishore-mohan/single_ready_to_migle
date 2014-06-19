ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

class MingleMailer < ActionMailer::Base
  default from: "cbletsmingle@gmail.com"

   def welcome_email
    @user = "mansoor.elahi@careerbuilder.com"
    @url  = 'http://letsmingle.com'
    mail(to: @user, subject: 'Welcome to My Awesome Site')
   end

  MingleMailer.welcome_email

end
