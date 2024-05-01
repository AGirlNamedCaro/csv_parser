# Earnings CSV Parser
- This system parses a 3-column CSV file and stores them appropriately into the database
- 2 user types
  - Employers
  - Employees 
- Each employer will have their own CSV layout (i.e. different column names and data formats for dates, dollar amounts, etc)
- Built on Ruby 3.1.1


## Assumptions
- All employees that work for the same employers have a **unique** external_reference number
- CSVs will only have 3 columns (a variation of external reference #, amount, and check date)
- CSV Layouts are **unique** to employers. They *cannot* be reused by another employer.