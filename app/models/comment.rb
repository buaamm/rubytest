class Comment < ActiveRecord::Base
  belongs_to :article
  validates :commenter, presence: true
  validates :body, length: { minimum: 3 }
end
