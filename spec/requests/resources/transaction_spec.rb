# frozen_string_literal: true

describe 'Quovo::Resources::Transaction', :vcr do
  describe '.find' do
    it 'returns the transaction' do
      response = Quovo.transactions.find(1)

      expect(response.status_code).to eql(200)
      expect(response.body.transaction).to be_present
    end
  end

  describe '.for_account' do
    it 'returns transactions for the given account' do
      test_successful_transactions(:account)
    end
  end

  describe '.for_connection' do
    it 'returns transactions for the given connection' do
      test_successful_transactions(:connection)
    end
  end

  describe '.for_user' do
    it 'returns transactions for the given user' do
      test_successful_transactions(:user)
    end
  end

  describe '.update' do
    let(:category) { 'Education' }

    it "updates the transaction's cashflow category" do
      response = Quovo.transactions.update(1, cashflow_category: category)

      expect(response.body.transaction[:cashflow_category]).to eql(category)
    end

    context 'cashflow_category param' do
      context "not in Quovo's list of cashflow categories" do
        it 'returns bad request' do
          response = Quovo.transactions.update(1, cashflow_category: :bad_type)

          expect(response.status_code).to eql(400)
        end
      end
    end
  end

  def test_successful_transactions(for_type)
    response = Quovo.transactions.send("for_#{for_type}", 1)

    expect(response.status_code).to eql(200)
    expect(response.body.transactions.size).to eql(1)
  end
end
