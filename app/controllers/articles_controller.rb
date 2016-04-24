class ArticlesController < ApplicationController
  before_action :get_article, only:[:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: "gustavo", password: "secret", except: [:index, :show]

  def get_article
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(params_article)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def create
    @article = Article.new(params_article)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
    def params_article
      params.require(:article).permit([:title, :text])
    end
end
