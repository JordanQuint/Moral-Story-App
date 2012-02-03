class StoryController < ApplicationController
  
  def index
    @stories = Story.paginate(:page => params[:page], :per_page => 20)
  end

  def show
  end

  def create
    @story = Story.create(params)
    @story.save
  end

  def new
    @story = Story.new
  end

  def destroy
  end

  def upvote
  end

  def downvote
  end

end
