require 'csv'

class EarningsParser
  def initialize(csv_earnings_data, employer)
    @csv_earnings_data = csv_earnings_data
    @employer = employer
  end

  def csv_sheet
    @csv_sheet = look_for_empty_rows(CSV.parse(@csv_earnings_data, headers: true).map(&:to_h))
  end

  def create_earning
    Earning.insert_all(compare_csv_and_layout(@csv_sheet))
  end

  private

  def look_for_empty_rows(csv_sheet)
    csv_sheet.each { |row| check_values(row) }
  end

  def check_values(row)
    row.each do |key, value|
      raise StandardError, "Missing Values in CSV, please check file and try again" if value.nil?
    end
  end

  def find_layout(employer)
    Employer.find(employer.id).layout
  end

  def compare_csv_and_layout(csv_sheet)
    layout = find_layout(@employer)
    new_sheet = []

    if layout
      csv_sheet.each do |row|
        emp_id = Employee.find_by(external_ref: row[layout.ext_ref_num_label]).id
        updated_amount =  row[layout.amount_label].delete '$'
        new_sheet.append({ "earning_date": row[layout.earning_date_label], "amount_cents": updated_amount.to_f * 100, "employee_id": emp_id })

        new_sheet
      end
    else
      raise StandardError, "Employer layout not recognized"
    end
    new_sheet
  end
end
