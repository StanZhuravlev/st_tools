module StTools
  module Module
    module Integer

      # Переводит число в строку с размером в байтах, кбайтах, Мбайтах и пр.
      #
      # @return [String] строка с суффиксом
      def human_bytes
        ::StTools::Human.bytes(self)
      end

      # Переводит число в значение boolean (true или false). Любое число false кроме 1 (единицы)
      #
      # @return [Boolean] true или false
      def to_bool
        ::StTools::String.to_bool(self)
      end

    end
  end
end
