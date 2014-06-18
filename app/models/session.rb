class Session < ActiveRecord::Base
  attr_accessor :email, :password, :match
  attr_accessible :email, :password

  belongs_to :user

  before_validation :authenticate_user

  validates_presence_of :match,
                        :message => 'for your name and password could not be found',
                        :unless => :session_has_been_associated?

  before_save :associate_session_to_user

  private

  def authenticate_user
    if not session_has_been_associated? and valid_credentials?
      user = User.where(
          email_id: self.email
          ).first_or_create
      self.match = user
    else
      self.match = nil
    end
  end

  def valid_credentials?
    mingle_user.valid_credentials?
  end

  def mingle_user
    Mingle4r::MingleClient.new('https://careerbuilder.mingle.thoughtworks.com/',
                               self.email, self.password)
  end

  def associate_session_to_user
    self.match = User.where(
        email_id: self.email
    ).last
    self.user_id ||= self.match.try(:id)
  end

  def session_has_been_associated?
    associate_session_to_user
    not self.user_id.nil?
  end
end
