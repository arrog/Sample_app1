require 'spec_helper'

describe WallDebsController do

  describe "GET 'title:string'" do
    it "returns http success" do
      get 'title:string'
      response.should be_success
    end
  end

  describe "GET 'context:string'" do
    it "returns http success" do
      get 'context:string'
      response.should be_success
    end
  end

  describe "GET 'likes:integer'" do
    it "returns http success" do
      get 'likes:integer'
      response.should be_success
    end
  end

  describe "GET 'dislikes:integer'" do
    it "returns http success" do
      get 'dislikes:integer'
      response.should be_success
    end
  end

  describe "GET 'neutral:integer'" do
    it "returns http success" do
      get 'neutral:integer'
      response.should be_success
    end
  end

end
