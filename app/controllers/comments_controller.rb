class CommentsController < ApplicationController
  before_action :select_current_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new

    @comment.comment = params[:comment][:comment]
    @comment.user = current_user
    @comment.project = Project.find(params[:project_id])

    @comment.save

    redirect_to project_url(params[:project_id])
  end

  def edit
  end

  def update
    @comment.comment = params[:comment][:comment]

    @comment.save

    redirect_to project_url(Project.find(@comment.project_id))
  end

  def destroy
    @comment.destroy
    redirect_to project_url(Project.find(@comment.project_id))
  end

  private

  def select_current_comment
    @comment = Comment.find(params[:id])
    @project = Project.find(params[:project_id])
  end
end
