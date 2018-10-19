class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :reward, optional: true

  validate :user_not_owner, :dollar_amount_equals_reward
  validates :dollar_amount, numericality: { greater_than: 0 }
  validates :dollar_amount, presence: true

  def user_not_owner
    errors.add(:user, " cannot pledge towards own project!") if self.user == project.user
  end


  def dollar_amount_equals_reward
    if reward
      errors.add(:base, "Reward pledge cannot be lower than reward cost!") if self.dollar_amount < reward.dollar_amount
    end
  end

end
