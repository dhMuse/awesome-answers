class Answer < ActiveRecord::Base
  belongs_to :question

  validates_presence_of :body

  scope :ordered_by_creation, -> { order("created_at DESC")}

end
