class User < ApplicationRecord
  validates :username, :password_digest, uniqueness: true, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true, uniqueness: true

  before_validation :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    if user && BCrypt::Password.new(user.password_digest).is_password?(password)
      user
    else
      nil
    end
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
