# Rails 4
# class Post < ActiveRecord::Base

class Post < ApplicationRecord
  validates :content, presence: true

  belongs_to :group, counter_cache: :post_count
  belongs_to :author, class_name: "User", foreign_key: :user_id

  scope :recent, -> { order("updated_at DESC")}

  def editable_by?(user)
    user && user == author
  end
end
