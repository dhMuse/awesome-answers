require "spec_helper"

feature "Creating a Quesiton" do
	let(:user) {create(:user)}
	before do
		login_as(user, :scope => :user)
	end
	it "creates an question in the database" do
		visit questions_path
		click_on "Create New Question"
		fill_in "Question here", with: "Some valid question title"
		fill_in "Description here", with: "Some valid question description"
		click_on "Save"
		save_and_open_page
		expect(current_path).to eq(questions_path)
		expect(page).to have_text /Some valid question title/i
	end
	it "doesn't create an question with an empty title" do
		visit new_question_path
		fill_in "Description here", with: "Some valid description"
		click_on "Save"
		expect(page).to have_text /Title must be present/i
		expect(Question.count).to eq(0)
	end
end