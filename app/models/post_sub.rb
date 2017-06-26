class PostSub < ApplicationRecord
  validates :post, :sub, presence: true
  validates :post, uniqueness: { scope: :sub }

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Post

  belongs_to :sub,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Sub
end
