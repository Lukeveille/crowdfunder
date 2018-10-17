class Reward < ActiveRecord::Base
  belongs_to :project
  belongs_to :pledge

  validates :description, :dollar_amount, presence: true
end
