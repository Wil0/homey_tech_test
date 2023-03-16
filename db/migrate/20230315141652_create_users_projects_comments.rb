# frozen_string_literal: true

class CreateUsersProjectsComments < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, if_not_exists: true do |t|
      t.string :title
      t.text :description
      t.string :status

      t.timestamps
    end

    create_table :users, if_not_exists: true do |t|
      t.string :first_name
      t.string :last_name
      t.index [:first_name, :last_name], unique: true
      t.timestamps
    end

    create_table :comments, if_not_exists: true do |t|
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :projects_users, id: false, if_not_exists: true do |t|
      t.references :project, null: false, foreign_key: true, unique: true
      t.references :user, null: false, foreign_key: true, unique: true
    end
  end
end
