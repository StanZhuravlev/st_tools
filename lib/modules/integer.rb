module StTools
  module Module
    module Integer

      # Переводит число в строку с размером в 'тыс.', 'млн.', 'трлн.' и пр.
      #
      # @return [String] строка с суффиксом
      def human_number
        ::StTools::Human.number(self)
      end

      # Переводит число в строку с размером в байтах, кбайтах, Мбайтах и пр.
      #
      # @return [String] строка с суффиксом
      def human_bytes
        ::StTools::Human.bytes(self)
      end

      # Переводит число в значение boolean (true или false). Любое число false кроме 1 (единицы)
      #
      # @return [Boolean] true или false
      # @example Примеры использования
      #   StTools::String.to_bool("1")       #=> true
      #   StTools::String.to_bool("0")       #=> false
      #   StTools::String.to_bool("10")      #=> false
      #   StTools::String.to_bool("-3")      #=> false
      def to_bool
        ::StTools::String.to_bool(self)
      end

      # Метод переводит целое число (число секунд) в человеко-удобное время в виде "1 минута 15 секунд назад"
      #
      # @return [String] строка с указанием количества секунд в форме "1 минута 15 секунд назад"
      # @example Примеры использования
      #   StTools::Setup.setup(:ru)
      #   345.seconds_ago                #=> "5 минут 45 секунд назад"
      #   24553.seconds_ago(false)       #=> 6 часов 49 минут"
      #   7364563738.seconds_ago         #=> "233 года 45 месяцев назад"
      def seconds_ago(ago = true)
        ::StTools::Human.seconds_ago(self, ago)
      end

    end
  end
end
