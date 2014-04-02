# controllers are named in the plural, models in the singular
class Question < ActiveRecord::Base
		validate :title, presence: {message: "must be there"}, uniqueness: true
		validates_presence_of :description, message: "must be present"

		# after_initialize :set_defaults

		default_scope {order("title ASC")} #careful with defaults, as the will apply to all queries

		has_many :answers, dependent: :destroy

		def self.recent_ten
			order("created_at DESC").limit(10)
		end
		# or: scope :recent_ten, -> { order("created_at DESC").limit(10)}
		# or: scope :recent_ten, lambda { order("created_at DESC").limit(10)}
		# "->" is shorthand for lambda

		# alternatively: scope :recent, lambda {|x| order("created_at DESC").limit(x)}
		# for these last, call recent(x)
		# or: def self.recent(x)
		# 			order("created_at DESC").limit(x)
		# 		end

		before_save :capitalize_title

		def capitalize_title
			self.title.capitalize!
		end

		# private

		# def set_defaults
			
		# end

end
