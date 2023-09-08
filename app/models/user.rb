class User < ApplicationRecord
    before_validation :downcase_username
    has_secure_password
    has_many :logola, dependent: :delete_all
    validates :name, presence: true, uniqueness: true, format: { with: /\A[a-zéáűúőóíA-ZÉÖÜÁŰŐÍ0-9\-_]+\z/,
    message: ": csak betűket és számokat tartalmazhat" }
    validates_uniqueness_of :email
    validates_length_of :password, minimum: 8
    validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    def downcase_username
        self.name = name.downcase if name.present?
      end
end
