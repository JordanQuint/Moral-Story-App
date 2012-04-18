class StoryController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :new, :destroy, :upvote, :downvote]
  
  def index
    @stories = Story.paginate(:page => params[:page], :per_page => 15)
  end

  def show
    @story = Story.find(params[:id])
    @new_comment = Comment.new
    @comments = Comment.find_all_by_comment_on_table_and_comment_on_id("stories", @story, :order => "created_at")
    unless params[:comment].nil? || params[:comment] == ""
      @important_comment = Comment.find(params[:comment])
      
      #set the Notification as viewed
      note = nil
      if params[:reply]
        note = Notification.find_by_user_id_and_target_id_and_from(@user.id, params[:reply_id], "comment reply")
      else
        note = Notification.find_by_user_id_and_target_id_and_from(@user.id, @important_comment.id, "new comment")
      end
      note.viewed = true
      note.save
    end
    
    #remove any notifications the user had for this story
    notes = Notification.all(:conditions => ["user_id = ? AND target_id = ? AND `from` LIKE '%story%'", @user.id, @story.id])
    notes.each { |note|
      note.viewed = true
      note.save
    }
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
    
    #notify all followers of the user that created this story
    main_user = User.find(params[:story][:user_id])
    
    main_user.followers.each { |user|
      Notification.create(:user_id => user.id,
                          :from => "user story",
                          :target_id => @story.id)
    }
    
    if !params[:story][:parent_id].nil? && params[:story][:parent_id] != ""
      #Notify everyone following the original story
      original_story = Story.find(params[:story][:parent_id])
      
      original_story.followers.each { |user|
        unless original_story.user_id == user.id
          Notification.create(:user_id => user.id,
                              :from => "related story",
                              :target_id => @story.id)
        end
      }
    end
    
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
                
        comment_replied_to.followers.each{ |user|
          unless comment_replied_to.user_id = user.id
            Notification.create(:user_id => user.id,
                                :from => "comment reply",
                                :target_id => comment.id)
          end
        }
        
      else #else it was a reply to a story
        Subscription.create(:user_id => params[:comment][:user_id],
                            :subscribed_to => "comments",
                            :target_id => comment.id)
        
        #Notify all the followers of this story
        story = Story.find(params[:comment][:comment_on_id])
        
        story.followers.each{ |user|
          unless story.user_id == user.id
            Notification.create(:user_id => user.id,
                                :from => "new comment",
                                :target_id => comment.id)
          end
        }
        
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
