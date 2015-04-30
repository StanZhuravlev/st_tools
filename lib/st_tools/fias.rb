module StTools
  class Fias

    #-------------------------------------------------------------
    #
    # Функции получения aoguid адресного объекта
    #
    #-------------------------------------------------------------

    # Функция возвращает aoguid города федерального значения Москва в системе ФИАС
    #
    # @return [String] aoguid г. Москва
    def self.moscow_aoguid
      return self.federal_cities['msk']
    end

    # Функция возвращает aoguid города федерального значения Санкт-Питербурга в системе ФИАС
    #
    # @return [String] aoguid г. Санкт-Питербурга
    def self.spb_aoguid
      return self.federal_cities['spb']
    end

    # Функция возвращает aoguid города федерального значения Севастополя в системе ФИАС
    #
    # @return [String] aoguid г. Севастополь
    def self.sevastopol_aoguid
      return self.federal_cities['svs']
    end

    # Функция возвращает aoguid города федерального значения Байконура в системе ФИАС
    #
    # @return [String] aoguid г. Байконур
    def self.baikonur_aoguid
      return self.federal_cities['bai']
    end


    # Метод проверяет, является ли aoguid городом федерального значения
    #
    # @param [String] aoguid адресного объекта из таблицы addrobj ФИАС
    # @return [Boolean] true, если объект - любой из городов федерального значения
    def self.federal?(aoguid)
      return true if self.federal_cities.values.include?(aoguid)
      return false
    end

    # Метод проверяет, является ли aoguid городом федерального значения Москва
    #
    # @param [String] aoguid адресного объекта из таблицы addrobj ФИАС
    # @return [Boolean] true, если объект - Москва
    def self.moscow?(aoguid)
      return true if self.federal_cities['msk'] == aoguid
      return false
    end

    # Метод проверяет, является ли aoguid городом федерального значения Санкт-Петербург
    #
    # @param [String] aoguid адресного объекта из таблицы addrobj ФИАС
    # @return [Boolean] true, если объект - Санкт-Петербург
    def self.spb?(aoguid)
      return true if self.federal_cities['spb'] == aoguid
      return false
    end

    # Метод проверяет, является ли aoguid городом федерального значения Севастополь
    #
    # @param [String] aoguid адресного объекта из таблицы addrobj ФИАС
    # @return [Boolean] true, если объект - Севастополь
    def self.sevastopol?(aoguid)
      return true if self.federal_cities['svs'] == aoguid
      return false
    end

    # Метод проверяет, является ли aoguid городом федерального значения Байконур
    #
    # @param [String] aoguid адресного объекта из таблицы addrobj ФИАС
    # @return [Boolean] true, если объект - Байконур
    def self.baikonur?(aoguid)
      if self.federal_cities['bai'] == aoguid
        return true
      end
      return false
    end


    # Метод проверяет, имеет ли переданная строка тип UUID
    #
    # @param [String] text исходная строка
    # @return [Boolean] true, если строка имеет тип UUID
    # @example Примеры использования
    #   StTools::Fias.uuid?('0c5b2444-70a0-4932-980c-b4dc0d3f02b5') #=> true
    #   StTools::Fias.uuid?('Hello, word!') #=> false
    def self.uuid?(text)
      return nil if text.nil?
      if text.match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/i)
        return true
      end
      return false
    end

    # Метод проверяет, яаляется строка почтовым индексом
    #
    # @param [String] text исходная строка
    # @return [Boolean] true, если строка является почтовым индексом
    # @example Примеры использования
    #   StTools::Fias.postalcode?('111141') #=> true
    #   StTools::Fias.postalcode?('   141207') #=> true
    #   StTools::Fias.postalcode?('Hello') #=> false
    #   StTools::Fias.postalcode?('1234') #=> false
    def self.postalcode?(text)
      return nil if text.nil?
      if text.to_s.strip.match(/^\d{6}$/)
        return true
      end
      return false
    end


    private

    # noinspection RubyClassVariableUsageInspection
    def self.federal_cities
      self_federal_cities = Hash.new

      self_federal_cities['msk'] = '0c5b2444-70a0-4932-980c-b4dc0d3f02b5' # Москва
      self_federal_cities['spb'] = 'c2deb16a-0330-4f05-821f-1d09c93331e6' # Санкт-Петербург
      self_federal_cities['svs'] = '63ed1a35-4be6-4564-a1ec-0c51f7383314' # Байконур
      self_federal_cities['bai'] = '6fdecb78-893a-4e3f-a5ba-aa062459463b' # Севастополь

      return self_federal_cities
    end

  end
end
