require 'rspec'
require 'st_tools'

describe 'Проверка методов StTools::Human.format_time2' do
    it '.format_time2 (:ru, :human, :full)' do
      StTools.configure { |config| config.locale = :ru }
      test = ::StTools::Human.format_time2(Time.now, :human, :full)
      expect(test).to match(/[а-я]{3,10}/)
      expect(test).to match(/г\./)
      expect(test).to match(/\d{2}\:\d{2}\:\d{2}/)
    end

    it '.format_time2 (:ru, :human, :full, god:false)' do
      StTools.configure { |config| config.locale = :ru }
      test = ::StTools::Human.format_time2(Time.now, :human, :full, god: false)
      expect(test).to match(/[а-я]{3,10}/)
      expect(test).to_not match(/г\./)
      expect(test).to match(/\d{2}\:\d{2}\:\d{2}/)
    end

    it '.format_time2 (:ru, :full, :full)' do
      StTools.configure { |config| config.locale = :ru }
      test = ::StTools::Human.format_time2(Time.now, :full, :full)
      expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
      expect(test).to match(/\d{2}\:\d{2}\:\d{2}/)
    end

    it '.format_time2 (:ru, :full, :short)' do
      StTools.configure { |config| config.locale = :ru }
      test = ::StTools::Human.format_time2(Time.now, :full, :short)
      expect(test).to match(/\d{2}\/\d{2}\/\d{4}/)
      expect(test).to_not match(/\d{2}\:\d{2}\:\d{2}/)
    end
end

