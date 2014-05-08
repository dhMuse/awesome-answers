require 'spec_helper'

describe User do
	describe ".full_name" do
		email = "bob@george.org"
		it "should return first name and last name as a string" do
			first_name = "Bob"
			last_name = "George"
			user = User.new(first_name: first_name, last_name: last_name, email: email)
			user.full_name
			expect(user.full_name).to eq("Bob George")
		end
		it "should return email as a string" do
			first_name = nil
			last_name = nil
			user = User.new(first_name: first_name, last_name: last_name, email: email)
			expect(user.full_name).to eq("bob@george.org")
		end
	end
end