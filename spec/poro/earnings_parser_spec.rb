require 'rails_helper'

RSpec.describe EarningsParser do

  describe 'csv_sheet' do
    let(:earnings_parser) { EarningsParser.new(csv_earnings_data) }
    let!(:csv_earnings_data) { 'ref_num,date,amount
A123,27/04/2024,$2000.70
B231,16/03/2024,$1000.00' }

    subject { earnings_parser.csv_sheet }

    context 'when columns are filled' do

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

  describe 'find_layout' do
    subject { described_class.find_layout(employer) }
    let!(:employer) { create(:employer) }
    let!(:layout) { create(:layout, employer:, ext_ref_num_label: 'External reference num', amount_label: 'Amount', earning_date_format: 'dd/mm/yyyy', earning_date_label: 'Check Date') }

    it 'retrieved layout' do
      expect(subject).to eq layout
      expect(subject.amount_label).to eq 'Amount'
      expect(subject.ext_ref_num_label).to eq 'External reference num'
      expect(subject.earning_date_format).to eq 'dd/mm/yyyy'
      expect(subject.earning_date_label).to eq 'Check Date'
    end
  end
end
