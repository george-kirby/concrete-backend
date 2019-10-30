class User < ApplicationRecord
    has_many :projects
    has_many :tasks, through: :projects
    has_many :steps, through: :tasks

    validates :email, presence: true
    validates :password, presence: true
end
