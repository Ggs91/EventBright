class UsersController < ApplicationController
  before_action :restrict_acess_to_owner, only: [:show]

  def show
  end

private
  def restrict_acess_to_owner
    unless User.find(params[:id]) == current_user 
      flash[:warning] = "Sorry, but you are only allowed to view your own profile page." 
      redirect_to root_path
    end
  end
end
