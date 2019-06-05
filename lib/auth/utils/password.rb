module Auth
  module Utils
    module Password
      def self.generate_password_hash(password)
        BCrypt::Password.create(password)
      end

      def self.compare_password(password, hash)
        BCrypt::Password.new(hash) == password
      end
    end
  end
end
