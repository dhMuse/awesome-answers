require 'spec_helper'

describe Answer do
	it "capitalizes answers before saving to database" do
		answer = Answer.new(body: "an answer")
		answer.save
		expect(answer.body).to eq("An answer")
	end
end