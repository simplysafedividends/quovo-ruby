# frozen_string_literal: true

describe 'Quovo::Resources::Connection', :vcr do
  describe '.all' do
    it 'returns all connections' do
      response = Quovo.connections.all
      expect(response.body.connections.size).to eql(2)
    end
  end

  describe '.find' do
    it 'returns the connection' do
      response = Quovo.connections.find(1)

      expect(response.status_code).to eql(200)
      expect(response.body.connection).to be_present
    end
  end

  describe '.for_user' do
    it 'returns the connections for the given user' do
      response = Quovo.connections.for_user(1)

      expect(response.status_code).to eql(200)
      expect(response.body.connections.size).to eql(1)
    end
  end
end
