class RewardsController < ApplicationController
  before_action :load_project
  before_action :confirm_ownership, only: [:destroy]

  def new
    @reward = Reward.new
  end

  def create
    @reward = @project.rewards.build
    @reward.dollar_amount = params[:reward][:dollar_amount]
    @reward.description = params[:reward][:description]

    if @reward.save
      redirect_to project_url(@project), notice: 'Reward created'
    else
      render :new
    end
  end

  def destroy
    @reward = Reward.find(params[:id])
    @reward.destroy

    redirect_to project_url(@project), notice: 'Reward successfully removed'
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end

  def confirm_ownership
    unless current_user == Reward.find(params[:id]).project.user
      if request.referer
        redirect_to request.referer
      else
        not_authenticated
      end
    end
  end

end
