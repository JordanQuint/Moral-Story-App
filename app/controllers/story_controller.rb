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
    Subscription.create(:user_id => params[:story][:user_id],
                        :subscribed_to => "stories",
                        :target_id => @story.id)
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
    if params[:comment][:content].length > 10
      #create the comment
      comment = Comment.create(params[:comment])
      
      #if the comment was a reply to another comment
      if params[:comment][:comment_on_table] == "comments"
        
        #subscribe the user to the original comment, unless they are already following it
        comment_replied_to = Comment.find(params[:comment][:comment_on_id])
        unless @user.is_following(comment_replied_to)
          Subscription.create(:user_id => params[:comment][:user_id],
                            :subscribed_to => "comments",
                            :target_id => comment.id)
        end
      else
        Subscription.create(:user_id => params[:comment][:user_id],
                            :subscribed_to => "comments",
                            :target_id => comment.id)
      end
    end
    redirect_to :back
  end
  
  def follow
    story = Story.find(params[:story])
    if @user.is_following(story)
      subscription = Subscription.find_by_user_id_and_subscribed_to_and_target_id(@user.id, "stories", story.id)
      Subscription.delete(subscription)
      flash.now[:notice] = "You are no longer following this story."
    else
      Subscription.create(:user_id => @user.id,
                          :subscribed_to => "stories",
                          :target_id => story.id)
      flash.now[:notice] = "You are now following this story."
    end
    redirect_to :back
  end

end
