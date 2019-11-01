class User < ApplicationRecord
    has_secure_password

    has_many :projects
    has_many :tasks, through: :projects
    has_many :steps, through: :tasks

    validates :email, presence: true
end
