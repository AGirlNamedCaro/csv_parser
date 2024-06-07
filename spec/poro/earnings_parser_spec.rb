require 'rails_helper'

RSpec.describe EarningsParser do

  describe 'csv_sheet' do
    let!(:csv_earnings_data) { 'ref_num,date,amount
A123,27/04/2024,$2000.70
B231,16/03/2024,$1000.00' }
    let(:employer) { create(:employer) }
    let(:earnings_parser) { EarningsParser.new(csv_earnings_data, employer) }

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

  describe 'create_earning' do
    subject { earnings_parser.create_earning }

    context 'layout for employerA' do
      let!(:csv_earnings_data) { 'Ext ref num,Date sent,Amount in dollars
A123,27/04/2024,$2000.70' }
      let!(:earnings_parser) { EarningsParser.new(csv_earnings_data, employerA) }
      let!(:csv_sheet) { earnings_parser.csv_sheet }
      let!(:employerA) { create(:employer) }
      let(:date) { Date.new(2024, 04, 27) }
      let!(:employeeA) { create(:employee, external_ref: 'A123', employer: employerA) }
      let!(:layoutA) { create(:layout, employer: employerA, ext_ref_num_label: 'Ext ref num', amount_label: "Amount in dollars", earning_date_format: 'mm/dd/yyyy', earning_date_label: 'Date sent') }

      it 'creates an earning' do
        expect { subject }.to change(Earning, :count).by(1)
        earning = Earning.last

        expect(earning.earning_date).to eq date
        expect(earning.amount_cents).to eq 200070
        expect(earning.employee_id).to eq employeeA.id
      end
    end

    context 'layout for employerB' do
      let!(:csv_earnings_data) { 'Ref num,Check date,Amount
123,20/07/2022,$4500.650' }
      let!(:earnings_parser) { EarningsParser.new(csv_earnings_data, employerB) }
      let!(:csv_sheet) { earnings_parser.csv_sheet }
      let!(:employerB) { create(:employer) }
      let(:date) { Date.new(2022, 07, 20) }
      let!(:employeeB) { create(:employee, external_ref: '123', employer: employerB) }
      let!(:layoutB) { create(:layout, employer: employerB, ext_ref_num_label: 'Ref num', amount_label: "Amount", earning_date_format: 'yyyy/mm/dd', earning_date_label: 'Check date') }

      it 'creates an earning' do
        expect { subject }.to change(Earning, :count).by(1)
        earning = Earning.last

        expect(earning.earning_date).to eq date
        expect(earning.amount_cents).to eq 450064
        expect(earning.employee_id).to eq employeeB.id
      end
    end
  end
end
