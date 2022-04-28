require_relative 'calculation'
require 'net/http'
require 'rexml/document'

begin
  uri = URI.parse('http://www.cbr.ru/scripts/XML_daily.asp'.freeze)
  response = Net::HTTP.get_response(uri)
  doc = REXML::Document.new(response.body)
  dollar_rate = doc.root.elements['Valute[@ID="R01235"]/Value'].text.tr(',', '.')
rescue SocketError => e
  puts "Ошибка соединения с сервером: #{e.message}"
  puts 'Курс доллара(введите значение вручную):'
  dollar_rate = STDIN.gets
end

puts 'Курс доллара:'
puts exchange_rate = dollar_rate.to_f

puts 'Сколько у вас рублей?'
quant_rubles = gets.to_f

puts 'Сколько у вас долларов?'
quant_dollars = gets.to_f
puts

calculate = Calculation.dual_portfolio(quant_rubles, quant_dollars, exchange_rate)
Calculation.calculation_output(calculate)
