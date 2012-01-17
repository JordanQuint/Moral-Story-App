class StoryController < ApplicationController
  
  def index
    @stories = Story.paginate(:page => params[:page], :per_page => 20)
  end

  def show
  end

  def create
  end

  def new
  end

  def destroy
  end

  def upvote
  end

  def downvote
  end

end
