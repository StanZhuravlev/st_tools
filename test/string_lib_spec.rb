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


end