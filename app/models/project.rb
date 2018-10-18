class Project < ActiveRecord::Base
  has_many :updates
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
  validates :goal, numericality: { greater_than: 0 }

  validate :end_date_if_cannot_be_before_start_date, :start_date_cannot_be_in_past

  def end_date_if_cannot_be_before_start_date
    if start_date != nil && end_date != nil && end_date < start_date
      errors.add(:end_date, "Must be later than start date.")
    end
  end

  def start_date_cannot_be_in_past
    if start_date != nil && Time.now != nil && start_date < Time.now
      errors.add(:start_date, "Start date cannot be in the past.")
    end
  end

  def total_amount_pledged
    self.pledges.sum(:dollar_amount)
  end

  def self.projects_funded
    @projects = Project.all
    @projects_funded = []
    @projects.each do |project|
      if project.total_amount_pledged > project.goal
        @projects_funded << project
      end
    end
    @projects_funded
  end


  def self.search(search)
    where("title ILIKE ?", "%#{search}%")
  end

end
