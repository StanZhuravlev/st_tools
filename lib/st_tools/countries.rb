module StTools
  class Countries
    AOGUIDS = {
        zz: '',
        ru: 'ea70abb2-ccc2-46c8-9b15-d42cac1ecd7f',
        ua: 'e6a4a903-01e6-43f0-9bad-e57c2eb4a9c7',
        kz: 'e501ac67-d26a-40c9-ad43-f1628807fdc0',
        by: 'ff26f2dc-759e-4196-9e28-4d6338c8e863'
    }

    COUNTRIES = {
        zz: {code: '', shortname: '', fullname: ''},
        ru: {code: 'ru', shortname: 'Россия', fullname: 'Российская Федерация'},
        ua: {code: 'ua', shortname: 'Украина', fullname: 'Украина'},
        kz: {code: 'kz', shortname: 'Казахстан', fullname: 'Республика Казахстан'},
        by: {code: 'by', shortname: 'Беларусь', fullname: 'Республика Беларусь'}
    }

    GEO = {
        zz: {location: [0.0, 0.0], upper: [0.0, 0.0], lower: [0.0, 0.0]},
        ru: {location: [99.505405, 61.698653], upper: [191.128003, 81.886117], lower: [19.484764, 41.18599]},
        ua: {location: [0.0, 0.0], upper: [0.0, 0.0], lower: [0.0, 0.0]},
        kz: {location: [0.0, 0.0], upper: [0.0, 0.0], lower: [0.0, 0.0]},
        by: {location: [0.0, 0.0], upper: [0.0, 0.0], lower: [0.0, 0.0]},
    }

    # Метод проверяет, яаляется ли UUID страной
    #
    # @param [String] uuid идентификатор страны
    # @return [Boolean] true, если идентификатор является идентификатором страны
    # @example Примеры использования
    #   StTools::Countries.country?('e6a4a903-01e6-43f0-9bad-e57c2eb4a9c7') #=> true
    #   StTools::Countries.country?('f5eea12d-e601-f043-9bad-e5789eefa9aa') #=> false
    #   StTools::Countries.country?('Hello') #=> false
    def self.country?(uuid)
      ::StTools::Countries::AOGUIDS.values.include?(uuid)
    end

    # Метод возвращает информацию о стране по ее идентификатору
    #
    # @param [String] id идентификатор страны (в виде aoguid, :ru, 'ru')
    # @return [Hash] hash описание страны
    # @example Примеры использования
    #   StTools::Countries.country('e6a4a903-01e6-43f0-9bad-e57c2eb4a9c7') #=> Hash
    #   StTools::Countries.country(:ru) #=> Hash
    #   StTools::Countries.country('ru') #=> Hash
    #   StTools::Countries.country('??') #=> Empty Hash
    def self.country(id)
      if ::StTools::Fias.uuid?(id)
        code = ::StTools::Countries::AOGUIDS.invert[id] || :zz
      else
        code = ::StTools::Countries::AOGUIDS.keys.include?(id.to_sym) ? id.to_sym : :zz
      end

      res = ::StTools::Countries::COUNTRIES[code].merge(::StTools::Countries::GEO[code])
      res[:aoguid] = ::StTools::Countries::AOGUIDS[code]
      res
    end


  end
end