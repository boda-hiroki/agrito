class CommentsController < ApplicationController
  def new
  end
  
  def create
    @comment = Comment.new(content: params[:content], user_id: @current_user.id, post_id: params[:post_id])
    if @comment.save
      flash[:notice] = 'コメントしました'
      redirect_to("/posts/#{params[:post_id]}")
    else
      flash[:notice] = 'コメントに失敗しました'
      redirect_to("/comments/#{params[:post_id]}/new")
    end
  end
end
