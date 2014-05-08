class Comment < ActiveRecord::Base
  belongs_to :answer
  validates :body, presence: true, length: {minimum: 3}
  scope :recent_ten, -> {limit(10).order("created_at DESC")}

  def sanitize
  	self.body.squeeze!(" ").strip!
  end
end
