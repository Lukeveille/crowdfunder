class PagesController < ApplicationController

  def index
    @projects = Project.all
    @total_ammount_pledged = Pledge.total_pledges
    @projects_funded = Project.projects_funded
  end

end
