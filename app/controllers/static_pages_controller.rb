# encoding: utf-8

class StaticPagesController < ApplicationController
  before_filter :store_location
    
  has_scope :permission_doulin
  has_scope :permission_debate
  
  def challenge
    @user = User.last
    @challenge = Challenge.last
  end
  
  def home
    @cats = Cat.all
    @challenge = Challenge.homepage.reverse!.first
    @challenge1 = Challenge.homepage.reverse![1]
    @challenge2 = Challenge.homepage.reverse![2]
    @doulin = Doulin.homepage.last
    @debate = Debate.homepage1.reverse!.first
    @debate1 = Debate.homepage2.reverse!.first
    @debate2 = Debate.homepage3.reverse!.first
    @debate3 = Debate.homepage4.reverse!.first
    @debate4 = Debate.homepage5.reverse!.first
    @citations = ["Soignez votre logorrhée.","Ils ne donnent plus de laine, mais leur avis."].shuffle()
    @citations2 =[["LES GROUPES","Un mini-moutoners dans moutoners.","Les groupes permettent de rencontrer et de discuter avec d’autres moutoners, créer des débats et joutes entre membres."],["LES JOUTES VERBALES","Des débats codifiés en comité réduit.","Vous pouvez défier vos amis, vos ennemis, ou de parfaits inconnus, en organisant de vraies joutes dialectiques. Il existe 4 types de défis: 1x1, 2x2, 4x1, 4x2."],["LES DEBATS OUVERTS","Des débats ouverts pour gens d'esprit.","Nous proposons des débats auxquels tout le monde peut participer: soyez pour, soyez contre ou suisse et argumentez en fonction."]].shuffle
  end

  def presse
    @argument1 = Argument.find(1)
    @argument2 = Argument.find(2)
    @argument3 = Argument.find(3)
    @argument4 = Argument.find(4)
    @citations2 =["Evolution du nombre d'abonnés", "Coût d'acquisition / Rentabilité", "Evolution du chiffre d'affaires", "Flux de trésorerie"]
  end

  def cgu
  end

  def presentation
  end
  
  def faq
  end
  
  def help
  end

  def about
    @citations2 =[["LES GROUPES","Un mini-moutoners dans moutoners.","Les groupes permettent de rencontrer et de discuter avec d’autres moutoners, créer des débats et joutes entre membres."],["LES JOUTES VERBALES","Des débats codifiés en comité réduit.","Vous pouvez défiez vos amis, vos ennemis, ou de parfaits inconnus, en organisantde vraies joutes dialectiques. Il existe 4 types de défis: 1x1, 2x2, 4x1, 4x2."],["LES DEBATS OUVERTS","Des débats ouverts pour gens d'esprit.","Nous proposons des débats auxquels tout le monde peut participer: soyez pour, soyez contre ou suisse et argumentez en fonction."]].shuffle
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
    
    @lists = (@doulins + @debates + @challenges).sort { |x,y| y.created_at <=> x.created_at }.paginate(:page => params[:page], :per_page =>8)
  end
  
  def list_doulins
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @doulins = Doulin.where(:cat_id => @current_category.id).permission_doulin
    else
      @doulins = Doulin.permission_doulin.sort { |x,y| y.created_at <=> x.created_at }.paginate(:page => params[:page], :per_page =>8)
    end
  end
  
  def list_debates
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @debates = Debate.where(:cat_id => @current_category.id).permission_debate
    else
      @debates = Debate.permission_debate.sort { |x,y| y.created_at <=> x.created_at }.paginate(:page => params[:page], :per_page =>8)
    end
  end
  
  def list_challenges
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @challenges = Challenge.where(:cat_id => @current_category.id)
    else
      @challenges = Challenge.all.sort { |x,y| y.created_at <=> x.created_at }.paginate(:page => params[:page], :per_page =>8)
    end
  end
  
  def list_ajoindre
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @challenges = Challenge.where(:cat_id => @current_category.id).incomplete
    else
      @challenges = Challenge.incomplete.all.sort { |x,y| y.created_at <=> x.created_at }.paginate(:page => params[:page], :per_page =>8)
    end
  end
  
  
  def search_results
    @tag_challenges = Challenge.tagged_with("#{params[:search]}")
    @title_search = Challenge.where(:title => params[:search])
    @challenges = @tag_challenges +   @title_search
    
    @users= User.where(name: params[:search])
    
    @tag_debates = Debate.tagged_with("#{params[:search]}")
    @title_debates = Debate.where(:title => params[:search]) 
    @debates = @tag_debates + @title_debates
    
    @tag_doulins = Doulin.tagged_with("#{params[:search]}")
    @title_doulins = Doulin.where(:title => params[:search])
    @doulins = Doulin.tagged_with("#{params[:search]}")
      
    @lists = (@doulins + @debates + @challenges).shuffle 
  end
  
end
