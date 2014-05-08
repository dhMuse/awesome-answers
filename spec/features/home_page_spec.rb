require "spec_helper"

feature "Visiting Home Page" do
	it "contains a text Questions" do
		visit root_path
		expect(page).to have_text /Questions/i
	end
	it "should list questions in the database" do
		question = create(:question)
		visit root_path
		save_and_open_page
		expect(page).to have_text /#{question.title}/i
	end
end