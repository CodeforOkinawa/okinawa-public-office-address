require 'csv'

File.open('addresses-utf8.tsv', 'w') {|f|
  CSV.open("./addresses.csv", "r:CP932:UTF-8", row_sep: "\r\n").each {|r|
    f.puts r.join("\t")
  }
}
