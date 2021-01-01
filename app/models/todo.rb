# frozen_string_literal: true

class Todo < ApplicationRecord
  validates :content, presence: true, allow_blank: false
end
