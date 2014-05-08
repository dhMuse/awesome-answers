class Answer < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :question
  has_many :comments, dependent: :destroy

  validates_presence_of :body
  before_save :capitalize_body
  scope :ordered_by_creation, -> { order("created_at DESC")}

  private

  def capitalize_body
  	self.body.capitalize!
  end

end
