# frozen_string_literal: true

class User < ApplicationRecord
  has_many :comments
  has_and_belongs_to_many :projects

  validates :first_name, presence: true, uniqueness: { scope: %i[first_name last_name] }
  validates :last_name, presence: true, uniqueness: { scope: %i[first_name last_name] }

  def full_name
    "#{first_name} #{last_name}"
  end
end
