# frozen_string_literal: true

class Comment < ApplicationRecord
  self.per_page = 3

  belongs_to :user

  validates :body, presence: true
end
