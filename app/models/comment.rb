class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket

  validates :body, presence: true
end
