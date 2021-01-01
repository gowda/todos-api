# frozen_string_literal: true

class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :content
      t.boolean :completed, default: false
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
