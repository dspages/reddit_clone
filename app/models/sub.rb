class Sub < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :moderations,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Moderation


  has_many :post_subs,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :PostSub

  has_many :posts,
    through: :post_subs,
    source: :post

  has_many :moderators,
    through: :moderations,
    source: :moderator
end
