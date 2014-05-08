class CommentsController < ApplicationController
	before_action :authenticate_user!
	def create
		find_answer
		@comment = @answer.comments.create(params.require(:comment).permit(:body))
		if @comment.save
			redirect_to @answer.question
		else
			flash.now[:alert] = "comment wasn't created"
			render "questions/show"
		end
	end
	def destroy
		find_answer
		@comment = Comment.find(params[:id])
		if @comment.destroy
			flash.now[:notice] = "comment deleted"
			redirect_to @answer.question
		else
			flash.now[:alert] = "failed to delete"
			redirect_to @answer.question
		end
	end
	private
	def find_answer
		@answer = Answer.find(params[:answer_id])
	end
end