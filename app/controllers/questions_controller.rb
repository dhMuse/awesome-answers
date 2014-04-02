# controllers are named in the plural, models in the singular
class QuestionsController < ApplicationController
	before_action :find_question,
								only: [:show, :edit, :destroy, :update, :vote_up, :vote_down]
	# or before_action :find_question, except: [:show, etc.]

	def index
		@questions = Question.all
	end

	def create

		# question_attributes = params.require(:question).permit([:title, :description])
		# the line above now appears under the private line 
		@question = Question.new(question_attributes)
		# @question.title = params[:question][:title]
		# @question.description = params[:question][:description]

		if @question.save
			redirect_to questions_path, notice: "Your question was created successfully"
		else
			flash.now[:error] = "Please attend to each form requirement"
			render :new
		end

	end

	def show
		# @question = Question.find params[:id]
		@answer = Answer.new
		@answers = @question.answers.ordered_by_creation
	end

	def edit
		# @question = Question.find params[:id]
	end

	def new
		@question = Question.new
	end

	def update
		# @question = Question.find params[:id]
		if @question.update_attributes(question_attributes)
			redirect_to @question, notice: "Question updated"
		else
			flash.now[:error] = "Update unsuccessful"
			render :edit
		end
	end

	def destroy
		if
			@question.destroy
			redirect_to questions_path, notice: "Question deleted"
		else
			redirect_to questions_path, error: "Couldn't delete"
		# render text: "Deleting question #{params[:id]}"
		end
	end

	def each
			
	end

	def vote_up
		@question.increment!(:vote_count)
		session[:has_voted] = true
		redirect_to @question
	end

	def vote_down
		# @question.
	end

	def search
		
	end

	private

	def question_attributes
		params.require(:question).permit(:title, :description)
		# setting the permit restricts users injecting other params and messing about
	end

	def find_question
		@question = Question.find params[:id]
		
	end

end
