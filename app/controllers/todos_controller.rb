# frozen_string_literal: true

class TodosController < ApplicationController
  def index
    @items = Todo.all
  end

  def create
    @item = Todo.create!(content: params[:content])

    render :show, status: :created
  end

  def update
    @item = Todo.find(params[:id])
    @item.update!(params.permit(:content, :completed).compact)

    render :show, status: :ok
  end

  def destroy
    @item = Todo.find(params[:id])

    @item.destroy

    render :show, status: :ok
  end
end
