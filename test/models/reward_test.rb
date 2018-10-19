require 'test_helper'

class RewardTest < ActiveSupport::TestCase

  def test_a_reward_can_be_created
    project = create(:project)
    reward = create(:reward, project: project)

    assert reward.valid?
    assert reward.persisted?
  end

  def test_a_reward_cannot_be_created_without_a_dollar_amount
    project = build(:project)
    reward = build(:reward, dollar_amount: nil, project: project)

    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  def test_a_reward_cannot_be_created_without_a_description
    project = build(:project)
    reward = build(:reward, description: nil)

    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end

  def test_reward_must_be_positive
    project = build(:project)
    reward = build(:reward, dollar_amount: -1)

    assert reward.invalid?, 'Reward should be invalid with a negative dollar amount'
  end

end
