class PagesController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end

  def search
    
    @results
    if params[:type] == "title"
      @results = Story.find(:all, :conditions => ["title LIKE ?", "%" + params[:query] + "%" ])
    elsif params[:type] == "users"
      @results = User.find(:all, :conditions => ["username LIKE ?", "%" + params[:query] + "%" ])
    elsif params[:type] == "age"
      @results = Story.find(:all, :conditions => ["age LIKE ?", "%" + params[:query] + "%" ])
    elsif params[:type] == "topic"
      @results = Story.find(:all, :conditions => ["topic LIKE ?", "%" + params[:query] + "%" ])
    elsif params[:type] == "educational_technique"
      @results = Story.find(:all, :conditions => ["educational_technique LIKE ?", "%" + params[:query] + "%" ])
    end
  end
end
