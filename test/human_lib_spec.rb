require 'rspec'
require 'st_tools'


describe 'Проверка методов StTools::Human.*' do
  it '.bytes(234)' do
    StTools.configure { |config| config.locale = :ru }
    test = ::StTools::Human.bytes(234)
    expect(test).to include('234')
    expect(test).to include('байт')
  end

  it '.bytes(14234)' do
    StTools.configure { |config| config.locale = :ru }
    test = ::StTools::Human.bytes(14234)
    expect(test).to include('14')
    expect(test).to include('кбайт')
  end

  it '.bytes(:en, 234)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.bytes(234)
    expect(test).to include('234')
    expect(test).to include('b')
  end

  it '.bytes(:en, 14234)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.bytes(14234)
    expect(test).to include('14')
    expect(test).to include('kb')
  end

  it '.number(234)' do
    StTools.configure { |config| config.locale = :ru }
    test = ::StTools::Human.number(234)
    expect(test).to include('234')
  end

  it '.number(14234)' do
    StTools.configure { |config| config.locale = :ru }
    test = ::StTools::Human.number(14234)
    expect(test).to include('14')
    expect(test).to include(' тыс.')
  end

  it '.number(:en, 234)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.number(234)
    expect(test).to include('234')
  end

  it '.number(:en, 14234)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.number(14234)
    expect(test).to include('14k')
  end

  it '.memory' do
    StTools.configure { |config| config.locale = :ru }
    test = ::StTools::Human.memory
    expect(test).to include('байт')
  end

  it '.human_ago (:ru)' do
    StTools.configure { |config| config.locale = :ru }
    test = ::StTools::Human.human_ago(DateTime.new(2001,2,3,4,5,6,'+7'), true)
    expect(test).to include('назад')
    expect(test).to include('лет')
  end

  it '.human_ago (:en)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.human_ago(DateTime.new(2001,2,3,4,5,6,'+7'), true)
    expect(test).to include('ago')
    expect(test).to include('years')
  end

  it '.seconds_ago (:ru)' do
    StTools.configure { |config| config.locale = :ru }
    test = ::StTools::Human.seconds_ago(67, true)
    expect(test).to include('назад')
    expect(test).to include('1 минута')
  end

  it '.seconds_ago (:en)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.seconds_ago(67, true)
    expect(test).to include('ago')
    expect(test).to include('1 minute')
  end

  it '.format_time (:ru)' do
    StTools.configure { |config| config.locale = :ru }
    test = ::StTools::Human.format_time(Time.now, :full, :full)
    expect(test).to match(/[а-я]{1,3}/)
    test = ::StTools::Human.format_time(Time.now, :full, :short)
    expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
  end

  it '.format_time (:en)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.format_time(Time.now, :full, :full)
    expect(test).to match(/[a-z]{1,3}/i)
    test = ::StTools::Human.format_time(Time.now, :full, :short)
    expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
  end

  it '.pretty_number(12345678)' do
    test = ::StTools::Human.pretty_number(12345678, round: 2)
    expect(test).to match('12 345 678,00')
  end

  it '.pretty_number(12345678)' do
    test = ::StTools::Human.pretty_number(12345678, round: 0)
    expect(test).to match('12 345 678')
  end

  it '.pretty_number(45678.6743)' do
    test = ::StTools::Human.pretty_number('45678.6743', round: 3)
    expect(test).to match('45 678,674')
  end

  it '.pretty_number(nil)' do
    test = ::StTools::Human.pretty_number(nil, round: 0)
    expect(test).to match('0')
  end

end

