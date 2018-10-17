class UpdatesController < ApplicationController

  def new
    @update = Update.new
    @project = Project.find(params[:project_id])
  end

  def create
    @update = Update.new
    @project = Project.find(params[:project_id])

    @update.title = params[:update][:title]
    @update.notes = params[:update][:notes]
    @update.project = @project

    if @update.save
      flash[:notice] = "update saved !"
      redirect_to "/projects/#{@project.id}"
    else
      render "projects/show"
    end
  end
end
