class MingleMailer < ActionMailer::Base
  default from: "cbletsmingle@gmail.com"

   def welcome_email(comment,url)
    @comment= comment
    @user = "mansoor.elahi@careerbuilder.com"
    @url  = url
    mail(to: @user, subject: 'Welcome to My Awesome Site').deliver
   end

end
