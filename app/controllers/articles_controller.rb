class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  respond_to :html
  
  def index
    @articles = Article.all
    respond_with(@articles)
  end
  
  def show
    @article = Article.find(params[:id])
    respond_with(@article)
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.find_or_create_by_url(params[:article])
    if @article.users.exists?(current_user) # current_user.articles.exists?(@article)
      @article.readinglists.find_by_user_id(current_user.id).touch
      flash[:notice] = "Successfully updated article."
      redirect_to root_url
    else
      @article.users << current_user
      if @article.save
        flash[:notice] = "Successfully created article."
      end
      redirect_to root_url
    end
  end
  
  def edit
    @article = current_user.articles.find(params[:id])
    respond_with(@article)
  end
  
  def update 
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = "Successfully updated article."
    end
      respond_with(@article)
  end
  
  def destroy
    @article = current_user.articles.find(params[:id])
    current_user.articles.delete(@article)
    flash[:notice] = "Successfully destroyed article."
    redirect_to root_url
  end
end
