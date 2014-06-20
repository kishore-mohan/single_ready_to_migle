class MingleMailer < ActionMailer::Base
  default from: "cbletsmingle@gmail.com"

   def welcome_email(user,comment,url,name)
    @comment= comment
    @user = LetsMingle.new(user.email_id, user.password, name).get_users
    @url  = url
    mail(to: @user, subject: 'Welcome to My Awesome Site').deliver
   end

end
