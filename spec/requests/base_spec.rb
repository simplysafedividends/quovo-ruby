describe 'Quovo::Base', :vcr do
  describe '.request' do
    let(:response) { Quovo.users.all }

    it 'returns an OpenStruct with success' do
      expect(response).to be_instance_of(OpenStruct)
    end

    context 'when credentials are incorrect' do
      before { Quovo.configure { |c| c.username = 'something_wrong' } }

      it 'raises Quovo::UnauthorizedError' do
        expect { response }.to raise_error(Quovo::UnauthorizedError)
      end
    end

    context 'when the response is a server error' do
      it 'raises Quovo::ApiError' do
        expect { response }.to raise_error(Quovo::ApiError)
      end
    end

    context 'token behavior' do
      context 'when token has expired' do
        before do
          Quovo.config.redis['quovo-token-expires-at'] = 1.day.ago
          Quovo.config.redis['quovo-token'] = :something
        end

        it 'fetches a new token before actual api request' do
          expect(Quovo::Token).to receive(:refresh).and_call_original
          response
        end
      end
    end
  end
end
