require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def test_total_amount_pledge_sum
    test_project = build(:project)

    test_pledge1 = build(:pledge)
    test_pledge1.project = test_project
    test_pledge1.user = build(:user)

    test_pledge2 = build(:pledge)
    test_pledge2.project = test_project
    test_pledge2.user = build(:user)

    test_pledge1.save
    test_pledge2.save

    actual = test_project.total_amount_pledged
    expected = test_pledge1.dollar_amount + test_pledge2.dollar_amount

    assert_equal(expected, actual, msg = 'Project total is not calculating properly')
  end

  def test_valid_project_can_be_created
    project = build(:project)
    user = create(:user)
    project.user = user
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  def test_project_is_invalid_without_owner
    project = build(:project)
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  def test_project_goal_must_be_positive
    project = build(:project)
    project.goal = -1
    project.save
    assert project.invalid?, 'Project should not save if the goal is a negative number.'
  end

  def test_project_invalid_if_end_date_before_start_date
    project = build(:project)
    project.end_date = project.start_date - 1.day
    project.save
    assert project.invalid?, 'Project should not save if end date is before start date.'
  end

  def test_project_start_must_be_in_future
    project = build(:project)
    project.start_date = Time.now - 1.day
    project.save
    assert project.invalid?, 'Project should not save if the start date is in the past.'
  end

end
