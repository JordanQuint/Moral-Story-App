class Notification < ActiveRecord::Base
  #The 'from' column is poorly designed, but rather than adjust it into better named columns,
  # I took advantage of its capability--explained here.
  
  #The 'from' column has four possible values:
    #"user story" indicates that a user they follow created a new story
    #"related story" indicates that someone submitted a story related to a story they follow
    #"comment reply" indicates someone replied to a comment they either created or also commented on
    #"new comment" indicates someone commented on a story they follow
  
  def from_user
    
    if self.caused_by == "user story"
      User.find(Story.find(self.target_id).user_id)
    elsif self.caused_by == "related story"
      User.find(Story.find(self.target_id).user_id)
    elsif self.caused_by == "comment reply"
      User.find(Comment.find(self.target_id).user_id)
    elsif self.caused_by == "new comment"
      User.find(Comment.find(self.target_id).user_id)
    end
    
  end
  
  def link
    response = ""
    if self.caused_by == "user story"
      response = "/story/" + self.target_id.to_s
    elsif self.caused_by == "related story"
      response = "/story/" + self.target_id.to_s
    elsif self.caused_by == "comment reply"
      comment = Comment.find(self.target_id)
      original_comment = Comment.find(comment.comment_on_id)
      story = comment.story
      response = "/story/" + story.id.to_s + "?comment=" + original_comment.id.to_s + "&reply=true&reply_id=" + comment.id.to_s
    elsif self.caused_by == "new comment"
      comment = Comment.find(self.target_id)
      story = comment.story
      response = "/story/" + story.id.to_s + "?comment=" + comment.id.to_s + "&reply=false"
    end
    
    return response
  end
end
