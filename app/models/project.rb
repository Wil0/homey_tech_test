# frozen_string_literal: true

class Project < ApplicationRecord
  has_and_belongs_to_many :users, -> { distinct }
  has_many :comments, through: :users

  validates :title, presence: true, uniqueness: true
  validates_associated :comments
end
