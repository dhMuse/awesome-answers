# controllers are named in the plural, models in the singular
class QuestionsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :find_question,
								only: [:edit, :destroy, :update, :vote_up, :vote_down]
	# or before_action :find_question, except: [:show, etc.]

	def index
		@recent_questions = Question.recent(3)
		@questions = Question.limit(10)
	end

	def create

		# question_attributes = params.require(:question).permit([:title, :description])
		# the line above now appears under the private line 
		@question = Question.new(question_attributes)
		# @question.title = params[:question][:title]
		# @question.description = params[:question][:description]

		@question.user = current_user
		# @question = current_user.questions.new(question_attributes)
		# the above line is equivalent to the line prior and the @question=Quesiton.new(question_attribues) line

		if @question.save
			expire_fragment "recent_questions"
			redirect_to questions_path, notice: "Your question was created successfully"
		else
			flash.now[:alert] = "Please attend to each form requirement"
			render :new
		end

	end

	def show
		@question = Question.find(params[:id])
		@answers = @question.answers.ordered_by_creation
		@answer = Answer.new
		if user_signed_in?
			@favourite = current_user.favourite_for(@question)
			@vote = current_user.vote_for(@question) || Vote.new
		end
	end

	def edit
		redirect_to root_path, alert: "Access Denied" unless can? :edit, @question
		# @question = Question.find params[:id]
	end

	def new
		@question = Question.new
	end

	def update
		# @question = Question.find params[:id]
		if @question.update_attributes(question_attributes)
			expire_fragment "recent_questions"
			redirect_to @question, notice: "Question updated"
		else
			flash.now[:alert] = "Update unsuccessful"
			render :edit
		end
	end

	def destroy
		if
			@question.destroy
			redirect_to questions_path, notice: "Question deleted"
		else
			redirect_to questions_path, alert: "Couldn't delete"
		# render text: "Deleting question #{params[:id]}"
		end
	end

	def each
			
	end

	def search
		
	end

	private

	def question_attributes
		params.require(:question).permit([:title, :description, {category_ids: []}, :image])
		# setting the permit restricts users injecting other params and messing about
	end

	def find_question
		@question = current_user.questions.find(params[:id])
		# redirect_to root_path, alert: "This isn't yours to change!" unless @question
	end

end
