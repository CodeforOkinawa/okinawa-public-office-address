require 'csv'

CSV.open("./addresses-utf8.csv", "w", row_sep:"\r\n", force_quotes: true) {|csv|
  CSV.open("./addresses.csv", "r:CP932:UTF-8", row_sep: "\r\n").each {|r| csv << r.to_a }
}
