class StaticPagesController < ApplicationController
  def home
    @cats = Cat.all
    @challenge = Challenge.first
    @doulin = Doulin.last
    @debate = Debate.first
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def list
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @challenges = Challenge.where(:cat_id => @current_category.id)
      @debates = Debate.where(:cat_id => @current_category.id)
      @doulins = Doulin.where(:cat_id => @current_category.id)
    elsif params[:tag]
        @challenges = Challenge.tagged_with(params[:tag], :on => :tags, :any => true)
        @debates = Debate.tagged_with(params[:tag], :on => :tags, :any => true)
        @doulins = Doulin.tagged_with(params[:tag], :on => :tags, :any => true)
    else
        @challenges = Challenge.all
        @debates = Debate.all
        @doulins = Doulin.all
    end
    
    @lists = (@doulins + @debates + @challenges).shuffle  
  end
  
  def search_results
    @challenges = Challenge.tagged_with("#{params[:search]}")
    @debates = Debate.tagged_with("#{params[:search]}")
    @doulins = Doulin.tagged_with("#{params[:search]}")
    
    @lists = (@doulins + @debates + @challenges).shuffle 
  end
  
end
