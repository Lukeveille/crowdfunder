class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :user_not_owner
  validates :dollar_amount, numericality: { greater_than: 0 }

  def user_not_owner
    errors.add(:user, " cannot pledge towards own project!") if self.user == project.user
  end
end
