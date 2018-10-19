require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_email_must_be_unique
    user = create(:user, email: "robert@gmail.com")
    user2 = build(:user, email: "robert@gmail.com")
    refute user2.valid?
  end

  def test_user_must_include_password_confirmation_on_create
    user = build(:user, email: "bettymaker@gmail.com", password: "12345678")
    refute user.valid?
  end

  def test_password_must_match_confirmation
    user = build(:user, email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "87654321")
    refute user.valid?
  end

  def test_password_must_be_at_least_8_characters_long
    user = build(:user, email: "bettymaker@gmail.com", password: "1234", password_confirmation: "1234")
    refute user.valid?
  end
end
