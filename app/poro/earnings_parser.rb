require 'csv'

class EarningsParser
  def initialize(csv_earnings_data, employer)
    @csv_earnings_data = csv_earnings_data
    @employer = employer
  end

  def csv_sheet
    @csv_sheet = look_for_empty_rows(CSV.parse(@csv_earnings_data, headers: true).map(&:to_h))
  end

  def store_earnings

  end

  private

  def look_for_empty_rows(csv_sheet)
    csv_sheet.each { |row| check_values(row) }
  end

  def check_values(row)
    row.each do |key|
      raise StandardError, "Missing Values in CSV, please check file and try again" if row[key].nil?
    end
  end
end