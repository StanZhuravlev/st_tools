require 'rspec'
require 'st_tools'

describe 'Проверка методов StTools::String.caps' do

  class String
    include ::StTools::Module::String
  end

  test = Hash.new
  test['stan.zhuravlev'] = 'Stan.Zhuravlev'
  test['н.а.римский-корсаков'] = 'Н.А.Римский-Корсаков'
  test['а.с. ПУШКИН'] = 'А.С. Пушкин'
  test['1-я владимирская улица'] = '1-я Владимирская Улица'
  test['ivan_petrov'] = 'Ivan_Petrov'


  test.each do |input, result|
    it input do
      test = ::StTools::String.caps(input)
      expect(test).to eq(result)
    end
  end

end