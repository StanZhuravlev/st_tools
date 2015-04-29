require 'rspec'
require 'st_tools'


describe 'Проверка методов StTools::Human.*' do
  it '.bytes(234)' do
    test = ::StTools::Human.bytes(234)
    expect(test).to include('234')
    expect(test).to include('байт')
  end

  it '.bytes(14234)' do
    test = ::StTools::Human.bytes(14234)
    expect(test).to include('14')
    expect(test).to include('кбайт')
  end

  it '.memory' do
    test = ::StTools::Human.memory
    expect(test).to include('байт')
  end

  it '.ago_in_words (:ru)' do
    ::StTools::Setup.setup(:ru)
    test = ::StTools::Human.ago_in_words(DateTime.new(2001,2,3,4,5,6,'+7'), true)
    expect(test).to include('назад')
    expect(test).to include('лет')
  end

  it '.ago_in_words (:en)' do
    ::StTools::Setup.setup(:en)
    test = ::StTools::Human.ago_in_words(DateTime.new(2001,2,3,4,5,6,'+7'), true)
    expect(test).to include('ago')
    expect(test).to include('years')
  end

  it '.format_time (:ru)' do
    ::StTools::Setup.setup(:ru)
    test = ::StTools::Human.format_time(Time.now, :full, :full)
    expect(test).to match(/[а-я]{1,3}/)
    test = ::StTools::Human.format_time(Time.now, :full, :short)
    expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
  end

  it '.format_time (:en)' do
    ::StTools::Setup.setup(:en)
    test = ::StTools::Human.format_time(Time.now, :full, :full)
    expect(test).to match(/[a-z]{1,3}/i)
    test = ::StTools::Human.format_time(Time.now, :full, :short)
    expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
  end

end