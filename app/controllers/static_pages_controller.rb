class StaticPagesController < ApplicationController
  
  has_scope :permission_doulin
  has_scope :permission_debate
  
  def home
    @cats = Cat.all
    @challenge = Challenge.first
    @doulin = Doulin.last
    @debate = Debate.first
  end

  def presse
    @challenges = Challenge.all
    @debates = Debate.all
    @lists = (@challenges +@debates).shuffle
  end
  def cgu
  end
  def help
  end
  
  def about
  end
  
  def contact
    @activities = PublicActivity::Activity.order("created_at desc")
  end
  
  def list
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @challenges = Challenge.where(:cat_id => @current_category.id)
      @debates = Debate.where(:cat_id => @current_category.id).permission_debate
      @doulins = Doulin.where(:cat_id => @current_category.id).permission_doulin
    elsif params[:tag]
        @challenges = Challenge.tagged_with(params[:tag], :on => :tags, :any => true)
        @debates = Debate.tagged_with(params[:tag], :on => :tags, :any => true).permission_debate
        @doulins = Doulin.tagged_with(params[:tag], :on => :tags, :any => true).permission_doulin
    else
        @challenges = Challenge.all
        @debates = Debate.permission_debate
        @doulins = Doulin.permission_doulin
    end
    
    @lists = (@doulins + @debates + @challenges).shuffle  
  end
  
  def list_doulins
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @doulins = Doulin.where(:cat_id => @current_category.id).permission_doulin
    else
      @doulins = Doulin.permission_doulin
    end
  end
  
  def list_debates
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @debates = Debate.where(:cat_id => @current_category.id).permission_debate
    else
      @debates = Debate.permission_debate
    end
  end
  
  def list_challenges
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @challenges = Challenge.where(:cat_id => @current_category.id)
    else
      @challenges = Challenge.all
    end
  end
  
  
  def search_results
    @challenges = Challenge.tagged_with("#{params[:search]}")
    @debates = Debate.tagged_with("#{params[:search]}")
    @doulins = Doulin.tagged_with("#{params[:search]}")
    
    @lists = (@doulins + @debates + @challenges).shuffle 
  end
  
end
