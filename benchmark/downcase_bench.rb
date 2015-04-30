#!/usr/bin/env ruby
#encoding: utf-8
require 'benchmark'
require 'active_support'
require 'active_support/core_ext'
require 'st_tools'

puts "Тестирование стандартной функции .downcase класса String"
Benchmark.bm do |bm|
  bm.report do
    100000.times do
      "Тестовая фраза на русском языке".mb_chars.downcase.to_s
    end
  end
end

class String
  include ::StTools::Module::String
end

puts "Тестирование функции .downcase класса StTools::String"
Benchmark.bm do |bm|
  bm.report do
    100000.times do
      "Тестовая фраза на русском языке".downcase
    end
  end
end
