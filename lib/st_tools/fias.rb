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
      if text.to_s.strip.match(/\A\d{6}\z/)
        return true
      end
      return false
    end

    # Метод расчитывает расстояние в метрах между двумя географическими точками
    #
    # @param [Float] from_lat - широта первой точки
    # @param [Float] from_long - долгота первой точки
    # @param [Float] to_lat - широта второй точки
    # @param [Float] to_long - долгота второй точки
    # @return [Float] расстояние в метрах между двумя точками
    # @example Примеры использования
    #   # Москва - Санкт-Петербург
    #   StTools::Fias.distance(55.75583, 37.61778, 59.95000, 30.31667)    #=> 634 988 м (635 км)
    #   # Москва - Киев
    #   StTools::Fias.distance(55.75583, 37.61778, 50.450500, 30.523000)  #=> 755 744 м (756 км)
    #   # Москва - Пермь
    #   StTools::Fias.distance(55.75583, 37.61778, 58.01389, 56.24889)    #=> 1 155 328 м (1 155 км)
    #   # Москва - Сан-Франциско
    #   StTools::Fias.distance(55.75583, 37.61778, 37.76667, -122.43333)  #=> 9 445 325 м (9 445 км)
    def self.distance(from_lat, from_long, to_lat, to_long)
      # coord - координата километровой отметки мкад
      rad_per_deg = Math::PI/180  # PI / 180
      rkm = 6371                  # Earth radius in kilometers
      rm = rkm * 1000             # Radius in meters

      dlat_rad = (to_lat.to_f - from_lat.to_f) * rad_per_deg  # Delta, converted to rad
      dlon_rad = (to_long.to_f - from_long.to_f) * rad_per_deg

      lat1_rad = from_lat.to_f * rad_per_deg
      lon1_rad = from_long.to_f * rad_per_deg

      lat2_rad = to_lat * rad_per_deg
      lon2_rad = to_long * rad_per_deg

      a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

      (rm * c).to_i # Delta in meters
    end



    private

    # noinspection RubyClassVariableUsageInspection
    def self.federal_cities
      self_federal_cities = Hash.new

      self_federal_cities['msk'] = '0c5b2444-70a0-4932-980c-b4dc0d3f02b5' # Москва
      self_federal_cities['spb'] = 'c2deb16a-0330-4f05-821f-1d09c93331e6' # Санкт-Петербург
      self_federal_cities['bai'] = '63ed1a35-4be6-4564-a1ec-0c51f7383314' # Байконур
      self_federal_cities['svs'] = '6fdecb78-893a-4e3f-a5ba-aa062459463b' # Севастополь

      return self_federal_cities
    end


  end
end
