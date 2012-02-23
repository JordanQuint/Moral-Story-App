class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :show_email, :show_name, :name, :username, :organization, :about
                  
  def stories
    Story.find_all_by_user_id(self.id)
  end
  
  def score
    Story.find(:all, :select => "SUM(score) AS total_score", :conditions => ["user_id = ?", self.id])[0][:total_score].to_i
  end
end
