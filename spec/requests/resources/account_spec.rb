# frozen_string_literal: true

describe 'Quovo::Resources::Account', :vcr do
  describe '.all' do
    it 'returns all accounts' do
      response = Quovo.accounts.all

      expect(response.status_code).to eql(200)
      expect(response.body.accounts.size).to eql(2)
    end
  end

  describe '.find' do
    it 'returns the account' do
      response = Quovo.accounts.find(1)

      expect(response.status_code).to eql(200)
      expect(response.body.account).to be_present
    end
  end

  describe '.for_connection' do
    it 'returns accounts for the given connection' do
      response = Quovo.accounts.for_connection(1)

      expect(response.status_code).to eql(200)
      expect(response.body.accounts.size).to eql(1)
    end
  end

  describe '.for_user' do
    it 'returns accounts for the given user' do
      response = Quovo.accounts.for_user(1)

      expect(response.status_code).to eql(200)
      expect(response.body.accounts.size).to eql(1)
    end
  end

  describe '.update' do
    let(:name) { 'new name' }

    it "updates the account's name" do
      response = Quovo.accounts.update(1, nickname: name)

      expect(response.body.account[:nickname]).to eql(name)
    end

    context 'type param' do
      context "not in Quovo's list of account types" do
        it 'returns bad request' do
          response = Quovo.accounts.update(1, type: :bad_type)

          expect(response.status_code).to eql(400)
        end
      end
    end
  end
end
