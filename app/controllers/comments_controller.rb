class CommentsController < ApplicationController

  def create
    @comment = Comment.new

    @comment.comment = params[:comment][:comment]
    @comment.user = current_user
    @comment.project = Project.find(params[:project_id])

    @comment.save

    redirect_to project_url(params[:project_id])
  end
end
