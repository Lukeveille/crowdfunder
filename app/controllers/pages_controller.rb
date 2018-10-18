class PagesController < ApplicationController

  def index
    @projects = Project.all
    @pledges = Pledge.all

    @projects.each do |project|
      if project.goal < Pledge.where(project_id: project.id).dollar_amount
        @Projects_funded << project
      end
    end
  end
end
