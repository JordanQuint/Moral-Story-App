class Comment < ActiveRecord::Base
  
  
  #Return an array of comments that are replies to this comment
  def replies
    Comment.find_all_by_comment_on_table_and_comment_on_id("comments", self.id)
  end
  
  def user
    User.find(self.user_id)
  end
end