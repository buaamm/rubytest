class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

  layout :resolve_layout

  def index
    flash[:req_ip] = "IP Address = %s, UserAgent = %s" % [request.remote_ip, request.user_agent] # TODO : Multilingual/I18n
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
      flash[:notice] = "创建成功 ID=" + @article.id.to_s # TODO : Multilingual/I18n
      redirect_to @article
    else
      flash.now[:error] = "创建失败" # TODO : Multilingual/I18n
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = "更新成功 ID=" + params[:id] # TODO : Multilingual/I18n
      redirect_to @article
    else
      flash.now[:error] = "更新失败" # TODO : Multilingual/I18n
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy # TODO : If destroy failed?
    flash[:notice] = "删除成功 ID=" + params[:id] # TODO : Multilingual/I18n
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

  private
    def resolve_layout # TODO : Different Templates
      case action_name
        when "new", "create"
          "application"
        when "index"
          "application"
        else
          "application"
      end
    end
      
end
