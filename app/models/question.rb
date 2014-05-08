# controllers are named in the plural, models in the singular
class Question < ActiveRecord::Base
		validates :title, presence: {message: "must be present"}, uniqueness: true
		validates_presence_of :description, message: "must be present"

		# after_initialize :set_defaults

		default_scope {order("title ASC")} #careful with defaults, as the will apply to all queries

		# has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ActionController::Base.helpers.asset_path("missing_:style.png")
  # 	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

		mount_uploader :image, ImageUploader

		has_many :favourites
		has_many :favourited_users, through: :favourites, source: :user

		belongs_to :user

		has_many :votes, dependent: :destroy
		has_many :voted_users, through: :votes, source: :user
		

		has_many :categorizations, dependent: :destroy
		has_many :categories, through: :categorizations

		has_one :question_detail
		# in terminal: question.create_question_detail(notes: "note")
		# and: question.build_question_detail(notes: "note") to instantiate without saving to db
		has_many :answers, dependent: :destroy
		has_many :comments, through: :answers

		def self.recent_ten
			order("created_at DESC").limit(10)
		end
		# or: scope :recent_ten, -> { order("created_at DESC").limit(10)}
		# or: scope :recent_ten, lambda { order("created_at DESC").limit(10)}
		# "->" is shorthand for lambda

		# alternatively: scope :recent, lambda {|x| order("created_at DESC").limit(x)}
		# for these last, call recent(x)
		# or: 
		def self.recent(x)
			order("created_at DESC").limit(x)
		end

		before_save :capitalize_title

		def capitalize_title
			self.title.capitalize!
		end

		# private

		# def set_defaults
			
		# end

end
