class User < ActiveRecord::Base
  has_secure_password
  has_many :projects
  has_many :comments


  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :email, presence: true

  validates :email, uniqueness: true

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end
end
