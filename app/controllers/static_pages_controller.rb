# encoding: utf-8

class StaticPagesController < ApplicationController
  before_filter :store_location
    
  has_scope :permission_doulin
  has_scope :permission_debate
  
  def home
    @cats = Cat.all
    @challenge = Challenge.first
    @doulin = Doulin.last
    @debate = Debate.first
    @users = User.all
    @citations = ["Apprenez l'art de la tatane dialectique.","Soignez votre logorrhée.", "Ils ne donnent plus de laine, mais leur avis.", "The first rule about moutoners: you do talk about moutoners."].shuffle
    @citations2 =[["Les Groupes","Avez-vous tenté de rejoindre un groupe ?","Les groupes permettent de rencontrer et de discuter avec d’autres moutoners, de former des équipes, créer des débats entre membres, bref, d’apporter une dose de convivalité à votre quête dialectique."],["LES DEFIS","Avez-vous participé
    à un défi ?","Vous pouvez défiez vos amis, vos ennemis, ou de parfaits inconnus, en organisantde vraies joutes dialectiques. Vous pouvez choisir d’être évalués par un jury, ou soumettrevos arguments au vote du public, qui déclareront le vainqueur."],["LES DEBATS OUVERTS","  Avez-vous participé
      à un débat ouvert ?","Les débats ouverts vous permettent de vous exprimer de manière argumentée surun sujet que le site vous propose. Prenez parti, soyez pour, soyez contre, soyez nipour ni contre, bien au contraire, et argumentez en fonction."],["LES EXPERTS","Avez-vous suivi un débat expert ?", "Vous pouvez suivre un débat expert, voter pour l’intellectuel que vous jugez le pluspertinent, et réagir en temps réel aux arguments de chacun."]].shuffle
  end

  def presse
    @argument1 = Argument.find(95)
    @argument2 = Argument.find(96)
  end
  def cgu
    @citations2 =[["Les petis blogs","Les petits blogs spécialisés sont une bonne rampe de lancement","Nous avons déjà trouvé un accord avec Bulles de savoir (philosophie) et avec DumDum (musique)."],["LES GROS MEDIAS","Ils seront primordiaux pour que Moutoners prenne son envol","Nous sommes en discussion avec Deux gros médias, Le Point et Atlantico. Mais les négociations n'avancent pas, ils attendent de voir comment va évoluer le projet."],["LES RESEAUX SOCIAUX SPECIALISES","Une synergie et une mutualisation des forces évidente.","Nous ciblons plusieurs cibles. Notamment Babelio, Vodkaster, senscritique et longueur d'onde."],["LES SEMIS GROS","Les Semi-gros sont notre priorité.", "Les sites d'informations  de taille intermédiaire, comme Slate, Evene ou Politis, qui ont une ligne éditoriale de qualité mais qui ont du mal à offrir un plus à leurs lecteurs, sont notre soucis actuels. Nous n'avons pour l'instant aucun contact."]].shuffle
  end
  
  def presentation
  end
  
  def faq
    @citations2 =[["Les Groupes","Avez-vous tenté de rejoindre un groupe ?","Les groupes permettent de rencontrer et de discuter avec d’autres moutoners, de former des équipes, créer des débats entre membres, bref, d’apporter une dose de convivalité à votre quête dialectique."],["LES DEFIS","Avez-vous participé
    à un défi ?","Vous pouvez défiez vos amis, vos ennemis, ou de parfaits inconnus, en organisantde vraies joutes dialectiques. Vous pouvez choisir d’être évalués par un jury, ou soumettrevos arguments au vote du public, qui déclareront le vainqueur."],["LES DEBATS OUVERTS","  Avez-vous participé
      à un débat ouvert ?","Les débats ouverts vous permettent de vous exprimer de manière argumentée surun sujet que le site vous propose. Prenez parti, soyez pour, soyez contre, soyez nipour ni contre, bien au contraire, et argumentez en fonction."],["LES EXPERTS","Avez-vous suivi un débat expert ?", "Vous pouvez suivre un débat expert, voter pour l’intellectuel que vous jugez le pluspertinent, et réagir en temps réel aux arguments de chacun."]].shuffle
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
    
    @lists = (@doulins + @debates + @challenges).shuffle.paginate(:page => params[:page], :per_page =>8)
  end
  
  def list_doulins
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @doulins = Doulin.where(:cat_id => @current_category.id).permission_doulin
    else
      @doulins = Doulin.permission_doulin.paginate(:page => params[:page], :per_page =>8)
    end
  end
  
  def list_debates
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @debates = Debate.where(:cat_id => @current_category.id).permission_debate
    else
      @debates = Debate.permission_debate.paginate(:page => params[:page], :per_page =>8)
    end
  end
  
  def list_challenges
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @challenges = Challenge.where(:cat_id => @current_category.id)
    else
      @challenges = Challenge.all.paginate(:page => params[:page], :per_page =>8)
    end
  end
  
  def list_ajoindre
    if params[:cat] && !params[:cat].empty?
      @current_category = Cat.find(params[:cat])
      @challenges = Challenge.where(:cat_id => @current_category.id).incomplete
    else
      @challenges = Challenge.incomplete.all.paginate(:page => params[:page], :per_page =>8)
    end
  end
  
  
  def search_results
    @tag_challenges = Challenge.tagged_with("#{params[:search]}")
    @title_search = Challenge.where(:title => params[:search])
    @challenges = @tag_challenges +   @title_search

    @tag_debates = Debate.tagged_with("#{params[:search]}")
    @title_debates = Debate.where(:title => params[:search]) 
    @debates = @tag_debates + @title_debates
    
    @tag_doulins = Doulin.tagged_with("#{params[:search]}")
    @title_doulins = Doulin.where(:title => params[:search])
    @doulins = Doulin.tagged_with("#{params[:search]}")
      
    @lists = (@doulins + @debates + @challenges).shuffle 
  end
  
end
