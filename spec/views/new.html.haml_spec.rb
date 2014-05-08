require "spec_helper"

describe "questions/new.html.erb" do
	before do
		assign(:question, stub_model(Question))
		render
	end
	it "contains text 'Create a New Question'" do
		expect(rendered).to match /Create a New Question/i
	end
	it "renders a form template" do
		expect(rendered).to render_template(partial: "_form")
	end
	# it "contains an h1 element" do
	# 	expect(rendered).to have_selector('h1')
	# end
end