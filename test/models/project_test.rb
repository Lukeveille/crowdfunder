require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def test_total_amount_pledge_sum
    test_project = new_project_with_user

    test_pledge1 = new_pledge
    test_pledge1.project = test_project
    test_pledge1.user = new_user
    
    test_pledge2 = new_pledge
    test_pledge2.project = test_project
    test_pledge2.user = new_user

    test_pledge1.save
    test_pledge2.save

    actual = test_project.total_amount_pledged
    expected = test_pledge1.dollar_amount + test_pledge2.dollar_amount

    assert_equal(expected, actual, msg = 'Project total is not calculating properly')
  end

  def test_valid_project_can_be_created
    project = new_project_with_user
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  def test_project_is_invalid_without_owner
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  def test_project_goal_must_be_positive
    project = new_project_with_user
    project.goal = -1
    project.save
    assert project.invalid?, 'Project should not save if the goal is a negative number.'
  end

  def test_project_invalid_if_end_date_before_start_date
    project = new_project_with_user
    project.end_date = project.start_date - 1.day
    project.save
    assert project.invalid?, 'Project should not save if end date is before start date.'
  end

  def test_project_start_must_be_in_future
    project = new_project_with_user
    project.start_date = Time.now - 1.day
    project.save
    assert project.invalid?, 'Project should not save if the start date is in the past.'
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

  def new_pledge
    Pledge.new(
      dollar_amount: 5
    )
  end

  def new_project_with_user
    owner = new_user
    owner.save
    project = new_project
    project.user = owner

    return project
  end

end
