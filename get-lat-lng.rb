#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'json'
require 'uri'
require 'open-uri'
require 'csv'

CSV.open('addresses.csv', 'w:CP932:UTF-8', row_sep:"\r\n") do |csv|
  csv << %w(自治体名 住所 lat lng GoogleMapsへのリンク)
  rows = DATA.readlines.map{|t|t.split(',').map(&:strip)}
  rows.each do |city, address|
    json = JSON.parse(open("http://maps.google.com/maps/api/geocode/json?address=#{URI.escape(address)}&sensor=false").read)
    sleep 1
    puts json

    unless json['status'] == 'OK' && json['results'] && (json['results'].size == 1 || json['results'].empty?)
      STDERR.puts "#{city}、#{address}の結果が#{json['results'].size}個です"
      next
    end

    result = json['results'][0]

    lat = result['geometry']['location']['lat']
    lng = result['geometry']['location']['lng']
    link = "https://www.google.co.jp/maps/preview?q=#{lat},#{lng}"
    csv << [city, address, lat, lng, link]
  end
end

__END__
那覇市,那覇市泉崎1-1-1
宜野湾市,宜野湾市字野嵩1-1-1
石垣市,石垣市美崎町14
浦添市,浦添市字安波茶1-1-1
名護市,名護市港1-1-1
糸満市,糸満市潮崎町1-1
沖縄市,沖縄市仲宗根町26-1
豊見城市,豊見城市字翁長854-1
うるま市,うるま市みどり町1-1-1
宮古島市,宮古島市平良字西里186
南城市,南城市玉城字富里143
国頭村,国頭村字辺土名121
大宜味村,大宜味村字大兼久157
東　村,東村字平良804
今帰仁村,今帰仁村字仲宗根219
本部町,本部町字東5
恩納村,恩納村字恩納2451
宜野座村,宜野座村字宜野座296
金武町,金武町字金武1
伊江村,伊江村字東江前38
読谷村,読谷村字座喜味2901
嘉手納町,嘉手納町字嘉手納588
北谷町,北谷町字桑江226
北中城村,北中城村字喜舎場426-2
中城村,中城村字当間176
西原町,西原町字嘉手苅112
与那原町,与那原町字上与那原16
南風原町,南風原町字兼城686
渡嘉敷村,渡嘉敷村字渡嘉敷183
座間味村,座間味村字座間味109
粟国村,粟国村字東367
渡名喜村,渡名喜村字渡名喜1917-3
南大東村,南大東村字南144-1
北大東村,北大東村字中野218
伊平屋村,伊平屋村字我喜屋251
伊是名村,伊是名村字仲田1203
久米島町,久米島町字比嘉2870
八重瀬町,八重瀬町字具志頭659
多良間村,多良間村字仲筋99-2
竹富町,石垣市美崎町11
与那国町,与那国町字与那国129
