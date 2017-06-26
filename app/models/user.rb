class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: {minimum: 8, allow_nil: true}

  before_validation :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(username,password)
    user=User.find_by_username(username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def password=(pw)
    @password=pw
    self.password_digest=BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  has_many :comments,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Comment

  has_many :posts,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Post

  has_many :moderations,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :Moderation

  has_many :subs_moderated,
    through: :moderations,
    source: :sub

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
