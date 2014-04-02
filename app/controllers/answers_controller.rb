class AnswersController < ApplicationController

	def create
		@question = Question.find params[:question_id]
		@answer = @question.answers.new(answer_attributes)
		if @answer.save
			redirect_to @question, notice: "Answer created successfully"
		else
			render "/questions/show"
		end
	end

	private

	def answer_attributes
		params.require(:answer).permit([:body])		
	end

end
