class User < ApplicationRecord
    has_secure_password

    has_many :tasks, dependent: :destroy

    validates :email, presence: true
    validates :email, uniqueness: true
end
