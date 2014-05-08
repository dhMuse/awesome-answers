class FavouritesController < ApplicationController
	before_action :authenticate_user!
	before_action :find_question

	def create
		@favourite = @question.favourites.new
		@favourite.user = current_user
		if @favourite.save
			redirect_to @question, notice: "I can haz so favourite!"
		else
			redirect_to @question, alert: "Already favourited, or something!"
		end
	end

	def destroy
		@favourite = current_user.favourites.find(params[:id])
		if @favourite.destroy
			redirect_to @question, notice: "U noeh like me noeh maor?"
		else
			redirect_to @question, alert: "Favourites are forever"
		end
	end

	private

	def find_question
		@question = Question.find(params[:question_id])
	end

end
