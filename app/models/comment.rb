class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :comment, :project_id, :user_id, presence: true

end
