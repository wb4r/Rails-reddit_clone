class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))     
    # @comment = @post.comments.build(params.require(:comment).permit!)
    @comment.creator = current_user
    # @comment.creator = User.first # DELETE LATER!
    # @comment = Comment.new(params.require(:comment).permit!)
    # @comment.post = @post

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      # render '/posts/show'
      flash[:error] = "You have to write few things in the comment box."
      redirect_to post_path(@post)
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote], )

    if current_user
      if vote.valid?
        flash[:notice] = "Your vote was counted on that comment."
      else
        flash[:error] = 'You can only vote once on a comment'
      end

      redirect_to :back
    else
      flash[:alert] = "You must log in to vote"
      redirect_to root_path
    end
  end
end