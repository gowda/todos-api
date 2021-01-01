# frozen_string_literal: true

describe TodosController do
  let(:headers) { { 'Accept' => 'application/json' } }

  describe 'GET /api/todos' do
    context 'when no items present' do
      it 'returns an empty array' do
        get '/api/todos', headers: headers

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to match_array([])
      end
    end

    context 'when items present' do
      let!(:items) { create_list(:todo, 12) }

      it 'returns all items in an array' do
        get '/api/todos', headers: headers

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response.length).to eql(12)
      end
    end
  end

  describe 'POST /api/todos' do
    context 'when body is blank' do
      it 'returns 422' do
        expect { post '/api/todos', headers: headers }.to(
          raise_error(ActiveRecord::RecordInvalid)
        )
      end
    end

    context 'when content is blank' do
      let!(:params) { { content: '     ' } }

      it 'returns 422' do
        expect { post '/api/todos', params: params, headers: headers }.to(
          raise_error(ActiveRecord::RecordInvalid)
        )
      end
    end

    context 'when content is not blank' do
      let!(:content) { 'test todo content' }

      it 'creates item' do
        post '/api/todos', params: { content: content }, headers: headers

        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body)
        expect(json_response['content']).to eql(content)
        expect(json_response['completed']).to be_falsey
      end
    end
  end

  describe 'PUT /api/todos/:id' do
    let!(:item) { create(:todo) }

    context 'when item does not exist' do
      it 'returns 404' do
        expect { put todo_path('non-existent-id'), headers: headers }.to(
          raise_error(ActiveRecord::RecordNotFound)
        )
      end
    end

    context 'when body is blank' do
      it 'returns unmodified item' do
        put todo_path(item), headers: headers

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['content']).to eql(item.content)
        expect(json_response['completed']).to eql(item.completed)
      end
    end

    context 'when content is blank' do
      it 'returns unmodified item' do
        put todo_path(item), headers: headers

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['content']).to eql(item.content)
        expect(json_response['completed']).to eql(item.completed)
      end
    end

    context 'when content is not blank' do
      let!(:content) { 'modified test todo content' }

      it 'returns modified item' do
        put todo_path(item), params: { content: content }, headers: headers

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['content']).to eql(content)
        expect(json_response['completed']).to eql(item.completed)
      end
    end

    context 'when completed is set' do
      it 'returns modified item' do
        put todo_path(item), params: { completed: true }, headers: headers

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['content']).to eql(item.content)
        expect(json_response['completed']).to be_truthy
      end
    end

    context 'when content & completed are set' do
      let!(:params) { { content: 'modified test todo content', completed: true } }

      it 'returns modified item' do
        put todo_path(item), params: params, headers: headers

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['content']).to eql(params[:content])
        expect(json_response['completed']).to eql(params[:completed])
      end
    end
  end

  describe 'DELETE /api/todos/:id' do
    context 'when item does not exist' do
      it 'returns 404' do
        expect { delete todo_path('non-existent-id'), headers: headers }.to(
          raise_error(ActiveRecord::RecordNotFound)
        )
      end
    end

    context 'when item exists' do
      let!(:item) { create(:todo) }

      it 'returns deleted item' do
        delete todo_path(item), headers: headers

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['content']).to eql(item.content)
        expect(json_response['completed']).to eql(item.completed)
      end
    end
  end
end
