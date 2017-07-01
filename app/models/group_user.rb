# Rails 4
# class GroupUser < ActiveRecord::Base

class GroupUser < ApplicationRecord
   belongs_to :group
   belongs_to :user
end
