# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Todo, type: :model do
  it 'raises error when content is blank' do
    expect { Todo.create!(content: ' ') }.to(
      raise_error(ActiveRecord::RecordInvalid)
    )
  end

  context 'with content' do
    subject { Todo.create(content: 'test todo item content') }
  end

  it 'sets completed to false' do
    expect(subject.completed).to be_falsey
  end
end
