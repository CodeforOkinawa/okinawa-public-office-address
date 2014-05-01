#!/usr/bin/env ruby

# ./get-addresses.rb > get-lat-lng.rb

require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

public_office_addresses_url = 'http://www.pref.okinawa.jp/handbook/No504.html'
html = open(public_office_addresses_url).read.force_encoding('CP932').scrub.encode('UTF-8')
doc = Nokogiri::HTML(html)

rows = doc.xpath('/html/body/table[3]/tbody/tr/td/div/table[2]/tbody//tr').drop(1)
puts rows.map{|tr| tr.search('td')}.map{|(city, _, address, _)| [city.text.strip, address.text.strip].join(',') }
