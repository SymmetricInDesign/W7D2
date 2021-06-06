class User < ApplicationRecord

    validates :email, presence: true, uniqueness: true
    validates :session_token, :password_digest, presence: true
    validates :password, allow_nil: true, length: {minimum: 6}

    attr_reader :password
    after_initialize :ensure_session_token

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token
        self.session_token ||= self.generate_session_token
    end

    def generate_session_token
        SecureRandom.urlsafe_base64
    end

    def reset_session_token!
        self.session_token = self.generate_session_token
        self.save
        self.session_token
    end
end