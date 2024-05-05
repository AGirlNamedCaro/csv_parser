require 'rails_helper'

RSpec.describe EarningsParser do
  describe 'csv_sheet' do

    let(:earnings_parser) { EarningsParser.new(csv_earnings_data) }

    subject { earnings_parser.csv_sheet }

    context 'when columns are filled' do
      let!(:csv_earnings_data) { 'ref_num,date,amount
A123,27/04/2024,$2000.70
B231,16/03/2024,$1000.00' }

      it 'parses csv' do
        expect(subject).to match_array([{ 'ref_num' => 'A123', 'date' => '27/04/2024', 'amount' => '$2000.70' }, { 'ref_num' => 'B231', 'date' => '16/03/2024', 'amount' => '$1000.00' }])
      end
    end

    context 'when there are missing values' do
      let!(:csv_earnings_data) { 'ref_num,date,amount
A123,27/04/2024,
B231,16/03/2024,$1000.00' }

      it 'raises an error' do
        expect { subject }.to raise_error(StandardError, 'Missing Values in CSV, please check file and try again')
      end
    end
  end
end
