module StTools
  module Module
    module Fias

      # Определяет принадлежность aoguid к федеральным городам (Москва, Санкт-Питербург, Байконур, Севастополь)
      #
      # @return [Boolean] true, если объект имеет тип uuid и равен aoguid одного из
      #   четырех федеральных городов
      def federal?
        ::StTools::Fias.federal?(self)
      end

      # Определяет, является ли aoguid Москвой
      #
      # @return [Boolean] true, если объект имеет тип uuid и равен aoguid Москвы
      def moscow?
        ::StTools::Fias.moscow?(self)
      end

      # Определяет, является ли aoguid Санкт-Петербургом
      #
      # @return [Boolean] true, если объект имеет тип uuid и равен aoguid Санкт-Петербурга
      def spb?
        ::StTools::Fias.spb?(self)
      end

      # Определяет, является ли aoguid Севастополем
      #
      # @return [Boolean] true, если объект имеет тип uuid и равен aoguid Севастополя
      def sevastopol?
        ::StTools::Fias.sevastopol?(self)
      end

      # Определяет, является ли aoguid Байконуром
      #
      # @return [Boolean] true, если объект имеет тип uuid и равен aoguid Байконура
      def baikonur?
        ::StTools::Fias.baikonur?(self)
      end

      # Определяет, содержит ли строка идентификатор типа uuid
      #
      # @return [Boolean] true, если строка имеет формат uuid
      def uuid?
        ::StTools::Fias.uuid?(self)
      end

      # Определяет, содержит ли строка почтовый индекс
      #
      # @return [Boolean] true, если строка имеет 6 цифр
      def postalcode?
        ::StTools::Fias.postalcode?(self)
      end

    end
  end
end
