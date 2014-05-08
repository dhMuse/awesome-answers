class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  has_many :favourites, dependent: :nullify
  has_many :favourited_questions, through: :favourites

  has_many :answers

  def email_required?
    provider.nil?
  end

  def self.find_or_create_from_twitter(oauth_data)
    user = User.where(provider: :twitter, uid: oauth_data["uid"]).first
    unless user
      name = oauth_data["info"]["name"].split(" ")
      user = User.create!(first_name: name[0], last_name: name[1],
        password: Devise.friendly_token[0, 20], provider: :twitter,
        uid: oauth_data["uid"])
    end
    user
  end

  def vote_for(question)
    Vote.where(question: question, user: self).first
  end

  def favourite_for(question)
    favourites.where(question: question).first
    # Favourite.where(question; question, user: self).first
    # the line above is the same as the line preceeding it.
    # the line below does something similar
    # favourited_questions.include? question
  end

  def full_name
  	if first_name || last_name
  		"#{first_name} #{last_name}".squeeze(" ").strip
  	else
  		email
  	end
  end

end
