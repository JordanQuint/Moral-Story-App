class Comment < ActiveRecord::Base
  
  
  #Return an array of comments that are replies to this comment
  def replies
    Comment.find_all_by_comment_on_table_and_comment_on_id("comments", self.id)
  end
  
  def user
    User.find(self.user_id)
  end
  
  def followers
    User.all(:joins => "JOIN subscriptions ON user_id = users.id",
              :conditions => ["subscribed_to = 'comments' AND target_id = ?", self.id])
  end
  
  def story
    if self.comment_on_table == "stories"
      return Story.find(self.comment_on_id)
    elsif self.comment_on_table == "comments"
      return Comment.find(self.comment_on_id).story
    end
  end
end