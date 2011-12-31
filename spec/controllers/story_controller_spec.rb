require 'spec_helper'

describe StoryController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'upvote'" do
    it "should be successful" do
      get 'upvote'
      response.should be_success
    end
  end

  describe "GET 'downvote'" do
    it "should be successful" do
      get 'downvote'
      response.should be_success
    end
  end

end
