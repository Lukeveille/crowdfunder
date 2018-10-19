require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

    def test_pledge_must_have_dollar_amount
      pledge = Pledge.create(
        dollar_amount: nil,
        project: new_project,
        user: new_user
      )
      pledge.save
      assert pledge.invalid?, 'A pledge must have a dollar amount'
    end

  def test_pledge_dollar_amount_must_be_positive
    pledge = Pledge.create(
      dollar_amount: -1,
      project: new_project,
      user: new_user
    )
    pledge.save
    assert pledge.invalid?, 'A pledge must be a positive dollar amount'
  end

  def test_a_pledge_can_be_created
    pledge = Pledge.create(
      dollar_amount: 99.00,
      project: new_project,
      user: new_user
    )
    pledge.save
    assert pledge.valid?
    assert pledge.persisted?
  end

  def test_owner_cannot_back_own_project
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    pledge = Pledge.new(dollar_amount: 3.00, project: project)
    pledge.user = owner
    pledge.save
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

  def test_pledge_must_be_higher_than_reward
    owner = create(:user)
    project = create(:project, user: owner)
    reward = create(:reward, dollar_amount: 150, project: project)
    pledge = build(:pledge, dollar_amount: 100, project: project, reward: reward)

    assert pledge.invalid?, 'A pledge should not claim a reward if it is lower than the reward dollar amount'
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end


end
