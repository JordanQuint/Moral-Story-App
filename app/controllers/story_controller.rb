class StoryController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :new, :destroy, :upvote, :downvote]
  
  def index
    # @stories = Story.all
    @stories = Story.paginate(:page => params[:page], :per_page => 15)
  end

  def show
    @story = Story.find(params[:id])
    @new_comment = Comment.new
    @comments = Comment.find_all_by_comment_on_table_and_comment_on_id("stories", @story, :order => "created_at")
  end

  def create
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
    @user = current_user
  end

  def destroy
  end

  def like
    story = Story.find(params[:story])
    if story.liked_by(@user)
      like = Like.find_by_story_id_and_user_id(story.id, @user.id)
      Like.delete(like)
    else
      Like.create(:user_id => @user.id,
                  :story_id => story.id)
    end
    redirect_to :back
  end
  
  def comment
    if params[:comment].length > 10
      Comment.create(params[:comment])
    end
    redirect_to :back
  end

end
