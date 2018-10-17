class Reward < ActiveRecord::Base
  belongs_to :project
  belongs_to :pledge

  validates :description, :dollar_amount, presence: true
  validates :dollar_amount, numericality: { greater_than: 0 }

end
