class User < ActiveRecord::Base
  
  #Includes gravtastic functionality
  include Gravtastic
  gravtastic #includes a method "gravatar_url" for avatars
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :show_email, :show_name, :name, :username, :organization,
                  :about
                  
  def stories
    Story.find_all_by_user_id(self.id)
  end
  
  def score
    Like.first(:select => "count(*) AS count", :joins => "JOIN stories ON likes.story_id = stories.id", :conditions => ["stories.user_id = ?", self.id]).count
  end
  
  def is_following(object)
    if object.class.to_s == "Story"
      !Subscription.first(:conditions => ["user_id = ? AND subscribed_to = 'stories' AND target_id = ?", self.id, object.id]).nil?
    elsif object.class.to_s == "User"
      !Subscription.first(:conditions => ["user_id = ? AND subscribed_to = 'users' AND target_id = ?", self.id, object.id]).nil?
    elsif object.class.to_s == "Comment"
      !Subscription.first(:conditions => ["user_id = ? AND subscribed_to = 'comments' AND target_id = ?", self.id, object.id]).nil?
    end
  end
end
