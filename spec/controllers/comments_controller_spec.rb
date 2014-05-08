require 'spec_helper'

describe CommentsController do
	let(:question) {create(:question)}
	let(:answer) {create(:answer, question: question)}
	let(:user) {create(:user)}
	describe '#create' do
		def valid_request
			post :create, answer_id: answer.id, comment: {body: 'valid body'}
		end
		def invalid_request
			post :create, answer_id: answer.id, comment: {body: ''}
		end
		context "without signed-in user" do
			it "doesn't create a record in the database" do
				expect {valid_request}.to_not change {Comment.count}
			end
			it "redirects users to sign-in page" do
				valid_request
				expect(response).to redirect_to(new_user_session_path)
			end
		end
		context "with signed-in user" do
			before {sign_in user}
			context "with valid request" do
				it 'creaes a comment in the database with valid parameters' do
					expect do
						expect {valid_request}.to change {Comment.count}.by(1)
					end
				end
				it "associates the comment with the answer which's id is passed" do
					expect do
						valid_request
					end.to change {answer.comments.count}.by(1)
				end
				it "redirects to the question page" do
					valid_request
					expect(response).to redirect_to(answer.question)
				end
			end
			context "with invalid request" do
				it "doesn't create comment" do
					expect { invalid_request}.to_not change {Comment.count}
				end
				it "renders the question show page" do
					invalid_request
					expect(response).to render_template("questions/show")
				end
				it "sets flash alerts" do
					invalid_request
					expect(flash[:alert]).to be
				end
			end
		end
	end
	describe '#destroy' do
		let!(:comment) {create(:comment, answer: answer)}
		def delete_request
			delete :destroy, answer_id: answer.id, id: comment.id
		end
		context 'without a signed-in user' do
			it 'redirects user to sign-in page' do
				delete_request
				response.should redirect_to(new_user_session_path)
			end
		end
		context 'with a signed-in user' do
			before {sign_in user}
			it "should decrease the number of comments by one" do
				expect {delete_request}.to change{Comment.count}.by(-1)
			end
			it 'redirects user to question page' do
				delete_request
				response.should redirect_to(answer.question)
			end
			it 'displays a flash notice message' do
				delete_request
				expect(flash[:notice]).to be
			end
		end
	end
end
