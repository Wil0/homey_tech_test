# frozen_string_literal: true

class Comment < ApplicationRecord
  self.per_page = 4

  belongs_to :user

  validates :body, presence: true
end
