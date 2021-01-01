# frozen_string_literal: true

json.array! @items do |item|
  json.content item.content
  json.completed item.completed
end
