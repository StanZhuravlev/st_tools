require 'rspec'
require 'st_tools'

describe 'Проверка методов StTools::Human.format_time2 (:ru)' do
    it '.format_time2 (:human, :full)' do
      StTools.configure { |config| config.locale = :ru }
      test = ::StTools::Human.format_time2(Time.now, :human, :full)
      expect(test).to match(/[а-я]{3,10}/)
      expect(test).to match(/г\./)
      expect(test).to match(/\d{2}\:\d{2}\:\d{2}/)
    end

    it '.format_time2 (:human, :full, god:false)' do
      StTools.configure { |config| config.locale = :ru }
      test = ::StTools::Human.format_time2(Time.now, :human, :full, god: false)
      expect(test).to match(/[а-я]{3,10}/)
      expect(test).to_not match(/г\./)
      expect(test).to match(/\d{2}\:\d{2}\:\d{2}/)
    end

    it '.format_time2 (:full, :full)' do
      StTools.configure { |config| config.locale = :ru }
      test = ::StTools::Human.format_time2(Time.now, :full, :full)
      expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
      expect(test).to match(/\d{2}\:\d{2}\:\d{2}/)
    end

    it '.format_time2 (:full, :short)' do
      StTools.configure { |config| config.locale = :ru }
      test = ::StTools::Human.format_time2(Time.now, :full, :short)
      expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
      expect(test).to_not match(/\d{2}\:\d{2}\:\d{2}/)
    end
end

describe 'Проверка методов StTools::Human.format_time2 (:en)' do
  it '.format_time2 (:human, :full)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.format_time2(Time.now, :human, :full)
    expect(test).to match(/[a-zA-Z]{3,10}/)
    expect(test).to match(/\d{2}\:\d{2}\:\d{2}/)
  end

  it '.format_time2 (:full, :full)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.format_time2(Time.now, :full, :full)
    expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
    expect(test).to match(/\d{2}\:\d{2}\:\d{2}/)
  end

  it '.format_time2 (:full, :short)' do
    StTools.configure { |config| config.locale = :en }
    test = ::StTools::Human.format_time2(Time.now, :full, :short)
    expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
    expect(test).to_not match(/\d{2}\:\d{2}\:\d{2}/)
  end
end

