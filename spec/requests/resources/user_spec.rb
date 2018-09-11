# frozen_string_literal: true

describe 'Quovo::Resources::User', :vcr do
  let(:username) { 'test@example.com' }

  describe '.all' do
    it 'returns all users' do
      response = Quovo.users.all
      expect(response.body.users.size).to eql(2)
    end

    context 'with username param' do
      it 'returns the matching user' do
        response = Quovo.users.all(username: username)
        expect(response.body.user[:username]).to eql(username)
      end

      context 'not found' do
        it 'returns not found' do
          response = Quovo.users.all(username: username)
          expect(response.status_code).to eql(404)
        end
      end
    end
  end

  describe '.create' do
    let(:name) { 'Test Example' }
    let(:email) { username }

    it 'creates a user' do
      response = Quovo.users.create(username: username, name: name, email: email)

      expect(response.status_code).to eql(201)
      %i(email name username).each { |attr| expect(response.body.user[attr]).to eql(send(attr)) }
    end

    context 'without username' do
      it 'raises ArgumentError' do
        expect { Quovo.users.create(name: name, email: email) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.destroy' do
    it 'destroys a user' do
      response = Quovo.users.destroy(1)

      expect(response.status_code).to eql(204)
      expect(response.body).to be_nil
    end
  end

  describe '.find' do
    it 'returns the user' do
      response = Quovo.users.find(1)

      expect(response.status_code).to eql(200)
      expect(response.body.user).to be_present
    end
  end

  describe '.update' do
    let(:new_name) { 'New Name' }

    it "updates the user's name" do
      response = Quovo.users.update(1, name: new_name)

      expect(response.body.user[:name]).to eql(new_name)
    end
  end
end
