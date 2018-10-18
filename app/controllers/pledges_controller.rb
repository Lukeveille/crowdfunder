class PledgesController < ApplicationController
  before_action :require_login

  def create
    @project = Project.find(params[:project_id])
    @pledge = @project.pledges.build
    @pledge.user = current_user

    @pledge.dollar_amount = params[:pledge][:dollar_amount]
    @pledge.reward_id = params[:pledge][:reward_id]

    if @pledge.save
      if params[:pledge][:reward_id]
        redirect_to project_url(@project), notice: "You have successfully backed #{@project.title} and claimed \"#{Reward.find(@pledge.reward_id).description}\"!"
      else
        redirect_to project_url(@project), notice: "You have successfully backed #{@project.title}!"
      end
    else
      @owner = User.find(@project.user_id)
      flash.now[:alert] = @pledge.errors.full_messages.first
      render 'projects/show'
    end
  end
  
end
