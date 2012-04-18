class Story < ActiveRecord::Base
  attr_accessible :story, :title, :characteristic, :age, :moral, :educational_technique,
                  :score, :parent_story, :user_id, :topic
  
  AGE_GROUPS = ["High School", "College", "Elementary", "Preschool", "Middle School", "General Public"]
  TECHNIQUES = ["Lecture", "Discussion", "Hands On"]
  
  #validations
  #no values can be empty except characteristics
  
  def author
    User.find(self.user_id)
  end
  
  def related_by_age
    Story.find_all_by_age(self.age, :order => "score DESC", :limit => 5)
  end
  
  def related_by_topic
    Story.find_all_by_topic(self.topic, :order => "score DESC", :limit => 5)
  end
  
  def related_by_technique
    Story.find_all_by_educational_technique(self.educational_technique, :order => "score DESC", :limit => 5)
  end
  
  def related_by_author
    Story.find_all_by_user_id(self.user_id, :order => "score DESC", :limit => 5)
  end
  
  def liked_by(user)
    !Like.find_by_story_id_and_user_id(self.id, user.id).nil?
  end
  
  def likes
    Like.first(:select => "count(*) AS size", :conditions => "story_id = '#{self.id}'").size
  end
  
  def followers
    User.all(:joins => "JOIN subscriptions ON user_id = users.id",
              :conditions => ["subscribed_to = 'stories' AND target_id = ?", self.id])
  end
end
