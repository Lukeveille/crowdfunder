require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

    def test_pledge_must_have_dollar_amount
      pledge = build(:pledge, dollar_amount: nil, project: build(:project), user: build(:user) )
      pledge.save
      assert pledge.invalid?, 'A pledge must have a dollar amount'
    end

  def test_pledge_dollar_amount_must_be_positive
    pledge = build(:pledge, dollar_amount: -1, project: build(:project), user: build(:user))
    assert pledge.invalid?, 'A pledge must be a positive dollar amount'
  end

  def test_a_pledge_can_be_created
    pledge = create(:pledge, project: build(:project), user: build(:user))
    assert pledge.valid?
    assert pledge.persisted?
  end

  def test_owner_cannot_back_own_project
    owner = create(:user)
    project = create(:project)
    project.user = owner
    project.save
    pledge = build(:pledge,project: project)
    pledge.user = owner
    pledge.save
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

  def test_pledge_must_be_higher_than_reward
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    reward = Reward.new(project: project, description: "word", dollar_amount: 10.0)
    reward.save
    pledge = Pledge.new(dollar_amount: 3.00, project: project, reward: reward)
    assert pledge.invalid?, 'A pledge should not claim a reward if it is lower than the reward dollar amount'
  end


end
