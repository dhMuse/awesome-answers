require "spec_helper"
describe ActionMailer do
	let(:user) {create(:user)}
	let(:user1) {create(:user)}
	let(:question) {create(:question, user: user)}
	let(:answer) {create(:answer, question: question, user: user1)}
	describe "#notify_question_owner" do
		subject {AnswerMailer.notify_question_owner(answer)}
		# 'subject' replaces an equivalent 'before' and the following lines replace the 'do/expect' statements. Good with short tests checking an attribute.
		its(:to) {should eq([user.email])}
		its(:from) {should eq(["noreply@awesomeanswers.com"])}
		# it "sends email from noreply@awesomeanswers.com" do
		# 	expect(@mail.from).to eq(["noreply@awesomeanswers.com"])
		# end
		its("body.encoded.to_s") {should match /#{answer.body}/i}
		# it "contains the answer body in the email body" do
		# 	expect(@mail.body.to_s).to match /#{answer.body}/i
		# end
	end
end