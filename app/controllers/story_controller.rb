class StoryController < ApplicationController
  
  def index
    @stories = Story.all
    # @stories = Story.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @story = Story.find(params[:id])
  end

  def create
    # @story = Story.create(params[:story], :score => 0)
    @story = Story.create(:user_id => params[:story][:user_id],
                          :title => params[:story][:title],
                          :story => params[:story][:story],
                          :age => params[:story][:age],
                          :topic => params[:story][:topic],
                          :educational_technique => params[:story][:educational_technique],
                          :parent_story => params[:story][:parent_id],
                          :moral => params[:story][:moral],
                          :score => 0)
    if @story.save
      redirect_to(story_path(@story), :notice => 'Your story was successfully created.')
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
