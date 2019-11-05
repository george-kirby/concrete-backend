class Task < ApplicationRecord
  belongs_to :project
  has_many :steps, dependent: :destroy

end
