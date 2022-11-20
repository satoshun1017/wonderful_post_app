class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index, show ]
  before_action :set_article, only: %i[ edit update destroy ]

  # GET /articles
  def index
    articles = Article.all
    articles = articles.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @articles = articles.page params[:page]
  end

  # GET /articles/1
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  def edit
  end


  # POST /articles
  def create


    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        redirect_to @article, notice: "Article was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @article.destroy
      redirect_to articles_url, notice: "Article was successfully destroyed."
  end



  private
    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :tag_ids[])
    end
end
