#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'
require 'csv'

public_office_addresses_url = 'http://ja.wikipedia.org/wiki/Template:%E6%B2%96%E7%B8%84%E7%9C%8C%E3%81%AE%E8%87%AA%E6%B2%BB%E4%BD%93'
html = open(public_office_addresses_url).read.force_encoding('UTF-8').scrub.encode('UTF-8')
doc = Nokogiri::HTML(html)

local_govs = doc.xpath('//*[contains(@class, "collapsible")]//tr//td[2]//a').to_a
local_govs.map! {|a|
  [
    a.text,
    URI.join(public_office_addresses_url, a[:href]).to_s
  ]
}

CSV.open('get-lat-lng.rb', 'wb') do |csv|
  local_govs.each {|g| csv << g }
end
