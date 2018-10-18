class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)

    if params[:search]
        @projects = Project.search(params[:search])
    end

  end

  def show
    @project = Project.find(params[:id])
    @owner = User.find(@project.user_id)
    @update = Update.new
    @total_pledged = 0
    @project.pledges.each do |pledge|
    @total_pledged += pledge.dollar_amount
    end
  end

  def new
    @project = Project.new
    @project.rewards.build
    @categories = Category.all
  end

  def create
    @project = Project.new
    @project.title = params[:project][:title]
    @project.description = params[:project][:description]
    @project.goal = params[:project][:goal]
    @project.start_date = params[:project][:start_date]
    @project.end_date = params[:project][:end_date]
    @project.image = params[:project][:image]
    @project.category_id = params[:project][:category_id]
    @project.user = current_user

    if @project.save
      redirect_to projects_url
    else
      @categories = Category.all
      render :new
    end
  end


end
