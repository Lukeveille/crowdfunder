require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def test_comment_needs_text
    comment = Comment.new(comment: nil, project_id: Project.first, user_id: User.first)
    assert comment.invalid?, "Comments should not be able to be created without text in the body"
  end
  def test_comment_needs_project
    comment = Comment.new(comment: 'a commment', project_id: nil, user_id: User.first)
    assert comment.invalid?, "Comments should not be able to be created without an assigned project"
  end
  def test_comment_needs_user
    comment = Comment.new(comment: 'a commment', project_id: Project.first, user_id: nil)
    assert comment.invalid?, "Comments should not be able to be created without a user"
  end
end
