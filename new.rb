#!/usr/bin/ruby

#
# get_curs.rb
#
# Александр Симаков, <xdr (тчк) box на Google Mail>
# http://alexander-simakov.blogspot.com/
#

# Подключаем библиотеку SOAP4R
require 'rubygems'
require_gem 'soap4r'

# Подключаем клиентские заглушки
require 'defaultDriver.rb'

# При помощи этого объекта мы будем вызывать
# методы веб-сервиса
serv = DailyInfoSoap.new

# Выводить отладочную информацию если ruby
# был запущен с ключом -d
serv.wiredump_dev = STDERR if $DEBUG

# Формируем запрос
request = GetCursOnDateXML.new(DateTime.now)

# Отправляем запрос на сервер и получаем ответ
response = serv.getCursOnDateXML(request)

# Анализируем ответ и выводим результат
items = response.getCursOnDateXMLResult.valuteData.valuteCursOnDate

items.each do |item|
  puts "---------------------------------"
  puts "Название: " + item['Vname'].strip
  puts "Числовой код: " + item['Vcode']
  puts "Символьный код: " + item['VchCode']
  puts "Номинал: " + item['Vnom']
  puts "Курс: " + item['Vcurs']
end