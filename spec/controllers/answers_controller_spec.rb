require "spec_helper"

describe AnswersController do
	let(:user) {create(:user)}
	let(:question) {create(:question)}
	context "with signed-in user" do
		before {sign_in user}
		describe "#create" do
			def valid_request
				post :create, question_id: question.id, answer: {body: "valid body"}
			end
			it "adds an answer record to the database" do
				expect do
					valid_request
				end.to change {question.answers.count}.by(1)
			end
			it "sends an email to question owner" do
				Delayed::Worker.delay_jobs = false
				ActionMailer::Base.deliveries.clear
				valid_request
				expect(ActionMailer::Base.deliveries).to have(1).item
			end
		end
	end
end