class User < ActiveRecord::Base

  has_many :estimation_details
  has_many :cards
  before_save :encrypt_password

  def encrypt_password
    if self.password and not self.password.blank?
      secret = Digest::SHA1.hexdigest("Hackathon")
      encrypt_secret = ActiveSupport::MessageEncryptor.new(secret)
      self.password = encrypt_secret.encrypt_and_sign(self.password)
    end
  end

  def self.password(password)
    secret = Digest::SHA1.hexdigest("Hackathon")
    encrypt_secret = ActiveSupport::MessageEncryptor.new(secret)
    encrypt_secret.decrypt_and_verify(password)
  end


end
