require 'bcrypt'

class User < ActiveRecord::Base
  has_many :posts

  validates :email, uniqueness: true
  validates :email, :name, :password, presence: true
  validates :email, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validate :password_is_longer_than_eight_characters

  def self.authenticate(name, password)
    logging_user = User.find_by(name: name)
    if logging_user && logging_user.password == password
      return logging_user
    end
    nil
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @plain_text = new_password
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

   def password_is_longer_than_eight_characters
     errors.add(:password, "must be longer than eight (8) characters") unless @plain_text && @plain_text.length >= 8
   end
end
