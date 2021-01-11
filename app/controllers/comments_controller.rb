class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, except: [:create]
  before_action :set_event


  def create
    comment = @event.comments.new(comment_params.merge(commenter: current_user))
    if comment.save 
      flash[:success] = "Your comment has been sent"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Your comment hasn't been sent"
      render @event
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end  
end
