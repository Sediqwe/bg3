class User < ApplicationRecord
    has_secure_password
    def admin?
        usertype == 1
      end
end
