class AnswerMailer < ActionMailer::Base
  default from: "noreply@awesomeanswers.com"
# to avoid getting filtered as junk, set 'from' to match the source 'gmail' as the setup
  def notify_question_owner(answer)
  	@answer = answer
  	@question = answer.question
  	@receiver = @question.user
  	mail(to: @receiver.email,
  			 subject: "You've got a new answer!")
  end
end
