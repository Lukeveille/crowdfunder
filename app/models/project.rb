class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
  validates :goal, numericality: { greater_than: 0 }
  
  validate :end_date_if_cannot_be_before_start_date, :start_date_cannot_be_in_past
  
  def end_date_if_cannot_be_before_start_date
    if end_date < start_date
      errors.add(:end_date, "Must be later than start date.")
    end
  end
  
  def start_date_cannot_be_in_past
    if start_date < Time.now
      errors.add(:start_date, "Start date cannot be in the past.")
    end
  end
end
