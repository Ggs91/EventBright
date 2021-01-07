class AvatarsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.avatar.attach(params[:avatar])
    redirect_back(fallback_location: root_path)
  end
end
