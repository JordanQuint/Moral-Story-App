class StoryController < ApplicationController
  
  def index
    @stories = Story.all
    # @stories = Story.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @story = Story.find(params[:id])
  end

  def create
    @story = Story.new(params[:story])
    if @story.save
      redirect_to(@story, :notice => 'Your story was successfully created.')
    else
      render :action => "new"
    end
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
