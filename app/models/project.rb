# frozen_string_literal: true

class Project < ApplicationRecord
  STATUSES = ['To Do', 'Pending', 'In Progress', 'Blocked'].map(&:freeze).freeze

  has_and_belongs_to_many :users, -> { distinct }
  has_many :comments, through: :users

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :title, presence: true, uniqueness: true
  validates_associated :comments
end
