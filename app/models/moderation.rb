class Moderation < ApplicationRecord
  validates :moderator, :sub, presence: true
  validates :moderator, uniqueness: {scope: :sub}

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User

  belongs_to :sub,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Sub
end
