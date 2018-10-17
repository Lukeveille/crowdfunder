require 'test_helper'

class RewardTest < ActiveSupport::TestCase

  def test_a_reward_can_be_created
    project = new_project
    project.save
    reward = Reward.create(
      dollar_amount: 99.00,
      description: 'A heartfelt thanks!',
      project: project
    )
    assert reward.valid?
    assert reward.persisted?
  end

  def test_a_reward_cannot_be_created_without_a_dollar_amount
    project = new_project
    project.save
    reward = Reward.create(
      description: 'A heartfelt thanks!',
      project: project
    )
    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  def test_a_reward_cannot_be_created_without_a_description
    project = new_project
    project.save
    reward = Reward.create(
      dollar_amount: 99.00,
      project: project
    )
    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end

  def test_reward_must_be_positive
    project = new_project
    project.user = new_user

    new_user.save
    project.save

    reward = Reward.create(
      dollar_amount: -1,
      description: 'The Negaverse',
      project: project
    )

    assert reward.invalid?, 'Reward should be invalid with a negative dollar amount'
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Time.now + 1.day,
      end_date:    Time.now + 1.month,
      goal:        50000
    )
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 "#{rand(99)}@gmail.com",
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end
end
