class CommentsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "admin", only: :destroy
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    if @comment.id
      flash[:notice] = "创建评论成功" # TODO : Multilingual/I18n
    else
      flash[:error] = "创建评论失败" # TODO : Multilingual/I18n
    end
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "删除评论成功" # TODO : Multilingual/I18n
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

end
