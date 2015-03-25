class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

  def index
    flash[:req_ip] = "IP Address = %s" % request.remote_ip # TODO : Multilingual/I18n
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "创建成功" # TODO : Multilingual/I18n
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = "更新成功" # TODO : Multilingual/I18n
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "删除成功" # TODO : Multilingual/I18n
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

end
