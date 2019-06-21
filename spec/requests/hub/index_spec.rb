# frozen_string_literal: true

RSpec.describe '/hubs', type: :request do
  before do
    Hub.create
    get('/hubs')
  end

  it 'returns 200 and correct response' do
    expect(response.status).to eq 200

    body = json(response.body)
    expect(body.size).to eq 1
  end
end
