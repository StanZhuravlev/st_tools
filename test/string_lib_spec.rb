require 'rspec'
require 'st_tools'

describe 'Проверка методов StTools::String.*' do

  class String
    include ::StTools::Module::String
  end

  it '.translit' do
    test = ::StTools::String.translit('Ярослав Му(y)дрёный')
    expect(test).to include('roslav')
    expect(test).to include('dren')
  end

  it '.normalize' do
    test = ::StTools::String.normalize('Ярослав    Му(y)дрёный')
    expect(test).to include('ярослав му(y)дреный')
  end

  it '.downcase("EngLish")' do
    test = ::StTools::String.downcase('EngLish')
    expect(test).to include('english')
  end

  it '.downcase("РуссКИЙ")' do
    test = ::StTools::String.downcase('РуссКИЙ')
    expect(test).to include('русский')
  end

  it '.upcase("EngLish")' do
    test = ::StTools::String.upcase('EngLish')
    expect(test).to include('ENGLISH')
  end

  it '.upcase("РуссКИЙ")' do
    test = ::StTools::String.upcase('РуссКИЙ')
    expect(test).to include('РУССКИЙ')
  end

  it '.hide_text' do
    test = ::StTools::String.hide('Ярослав    Му(y)дрёный')
    expect(test).to include('*')
  end

  it '.split(nil, "")' do
    test = ::StTools::String.split(nil, '')
    expect(test.count).to be 0
  end

  it '.split("Имя Фамилия", " ")' do
    test = ::StTools::String.split('Имя Фамилия', ' ')
    expect(test.count).to be 2
    expect(test.first).to eq('Имя')
    expect(test.last).to eq('Фамилия')
  end

  it '.split("Имя  ,  Фамилия, Анна", ",", normalize: true, sort: true)' do
    test = ::StTools::String.split("Имя  ,  Фамилия, Анна", ",", normalize: true, sort: true)
    expect(test.count).to be 3
    expect(test.first).to eq('анна')
    expect(test.last).to eq('фамилия')
  end

  it '.to_range(nil)' do
    test = ::StTools::String.to_range(nil)
    expect(test.count).to be 0
  end

  it '.to_range("3, 5-7, 456, 2")' do
    test = ::StTools::String.to_range("3, 5-7, 456, 2")
    expect(test.count).to be 6
    expect(test.first).to eq(3)
    expect(test.last).to eq(2)
  end

  it '.to_range("3, 5-7, 456, 2", sort: true)' do
    test = ::StTools::String.to_range("3, 5-7, 456, 2", sort: true)
    expect(test.count).to be 6
    expect(test.first).to eq(2)
    expect(test.last).to eq(456)
  end

  it '.caps("пеТР ильЧЕНКО")' do
    test = ('пеТР ильЧЕНКО').caps
    expect(test).to eq('Петр Ильченко')
  end

  it '"True".to_bool' do
    test = "True".to_bool
    expect(test).to eq(true)
  end

  it '"Off".to_bool' do
    test = "Off".to_bool
    expect(test).to eq(false)
  end

  it 'to_bool(nil, true)' do
    test = ::StTools::String.to_bool(nil, true)
    expect(test).to eq(true)
  end

  it 'to_bool(nil, true)' do
    test = ::StTools::String.to_bool(nil, false)
    expect(test).to eq(false)
  end

  it 'pretty_list(nil)' do
    test = ::StTools::String.pretty_list(nil)
    expect(test).to eq('')
  end

  it 'pretty_list - ru' do
    ::StTools::Setup.setup(:ru)
    test = ::StTools::String.pretty_list(['Паша'])
    expect(test).to eq('Паша')
    test = ::StTools::String.pretty_list(['Паша', 'Маша'])
    expect(test).to eq('Паша и Маша')
    test = ::StTools::String.pretty_list(['Паша', 'Маша', 'Саша'])
    expect(test).to eq('Паша, Маша и Саша')
    test = ::StTools::String.pretty_list(['Паша', 'Маша', 'Саша'], union: :or)
    expect(test).to eq('Паша, Маша или Саша')
    test = ::StTools::String.pretty_list(['Паша', 'Маша', 'Саша'], union: :or, pretag: '<em>', afttag: '</em>')
    expect(test).to eq('<em>Паша</em>, <em>Маша</em> или <em>Саша</em>')
  end

  it 'pretty_list - en' do
    ::StTools::Setup.setup(:en)
    test = ::StTools::String.pretty_list(['Паша'])
    expect(test).to eq('Паша')
    test = ::StTools::String.pretty_list(['Паша', 'Маша'])
    expect(test).to eq('Паша and Маша')
    test = ::StTools::String.pretty_list(['Паша', 'Маша', 'Саша'])
    expect(test).to eq('Паша, Маша and Саша')
    test = ::StTools::String.pretty_list(['Паша', 'Маша', 'Саша'], union: :or)
    expect(test).to eq('Паша, Маша or Саша')
    test = ::StTools::String.pretty_list(['Паша', 'Маша', 'Саша'], union: :or, pretag: '<em>', afttag: '</em>')
    expect(test).to eq('<em>Паша</em>, <em>Маша</em> or <em>Саша</em>')
  end

  it 'prune' do
    test = ::StTools::String.prune('1234567890', 20)
    expect(test).to eq('1234567890')
    test = ::StTools::String.prune('1234567890', 8)
    expect(test).to eq('12345...')
    test = ::StTools::String.prune('1234567890', 8, words: true)
    expect(test).to eq('12345...')
    test = ::StTools::String.prune('1234567890', 8, words: true, endwith: '---')
    expect(test).to eq('12345---')
    test = ::StTools::String.prune('Привет мир и природа', 12)
    expect(test).to eq('Привет ми...')
    test = ::StTools::String.prune('Привет мир и природа', 12, words: true)
    expect(test).to eq('Привет...')
  end

  it 'to_float' do
    expect(::StTools::String.to_float('123.45')).to eq(123.45)
    expect(::StTools::String.to_float('123.474565647335', round: 2)).to eq(123.47)
    expect(::StTools::String.to_float('123,474565647335', round: 2)).to eq(123.47)
    expect(::StTools::String.to_float('   123,474565647335', round: 2)).to eq(123.47)
    expect(::StTools::String.to_float('   10 123,474565647335', round: 2)).to eq(10123.47)
    expect(::StTools::String.to_float(' -  10 123,474565647335', round: 2)).to eq(-10123.47)
    expect((::StTools::String.to_float(nil, round: 2) rescue 'fail')).to eq('fail')
    expect((::StTools::String.to_float(nil, round: 2, stop: false) rescue 'fail')).to eq(0)
    expect((::StTools::String.to_float('no_digits', round: 2) rescue 'fail')).to eq('fail')
    expect((::StTools::String.to_float('no_digits', round: 2, stop: false) rescue 'fail')).to eq(0)
    expect(::StTools::String.to_float(145.5667, round: 2)).to eq(145.57)
    expect(::StTools::String.to_float(23, round: 2)).to eq(23)
  end

end