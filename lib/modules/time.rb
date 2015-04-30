module StTools
  module Module
    module Time

      # Метод переводит Date в строку на русском или иных языках. Предварительно необходимо вызвать
      # StTools.setup(:ru или :en).
      #
      # @param [Date] time исходная дата
      # @param [Sym] type форма в которой возращать результат: длинная ("28 апреля 2015 г.") или короткая ("28/04/2015")
      # @option :full длинна форма
      # @option :short короткая форма
      # @return [String] строка с форматированной датой
      # @example Примеры использования
      #   StTools::Setup.setup(:ru)
      #   Time.now.human_date(:full)       #=> "30 апреля 2015 г."
      #   Time.now.human_date(:short)      #=> "30/04/2015"
      def human_date(type = :full)
        ::StTools::Human.format_time(self, :date, type)
      end

      # Метод переводит Time в строку на русском или иных языках. Предварительно необходимо вызвать
      # StTools.setup(:ru или :en).
      #
      # @param [Time] time исходное время
      # @param [Sym] type форма в которой возращать результат: длинная ("10:34:52") или короткая ("10:34")
      # @option :full длинна форма
      # @option :short короткая форма
      # @return [String] строка с форматированным временем
      # @example Примеры использования
      #   StTools::Setup.setup(:ru)
      #   Time.now.human_time(:full)       #=> "08:54:34"
      #   Time.now.human_time(:short)      #=> "08:55"
      def human_time(type = :full)
        ::StTools::Human.format_time(self, :time, type)
      end

      # Метод переводит DateTime в строку на русском или иных языках. Предварительно необходимо вызвать
      # StTools.setup(:ru или :en).
      #
      # @param [DateTime] time исходные время и дата
      # @param [Sym] type форма в которой возращать результат: длинная ("28 апреля 2015 г. 10:34:52") или короткая ("28/04/2015 10:34")
      # @option :full длинна форма
      # @option :short короткая форма
      # @return [String] строка с форматированными датой и временем
      # @example Примеры использования
      #   StTools::Setup.setup(:ru)
      #   Time.now.human_datetime(:full)       #=> "30 апреля 2015 г. 08:54:34"
      #   Time.now.human_datetime(:short)      #=> "30/04/2015 08:55"
      def human_datetime(type = :full)
        ::StTools::Human.format_time(self, :full, type)
      end

      # Метод переводит DateTime в строку на русском или иных языках вида "4 дня 23 часа назад".
      # Предварительно необходимо вызвать StTools.setup(:ru или :en).
      #
      # @param [DateTime] time время и дата
      # @param [Boolean] ago true, если надо добавить слово "назад" в конец строки
      # @return [String] строка вида "3 дня 12 часов" или "3 дня 12 часов назад"
      # @example Примеры использования
      #   StTools::Setup.setup(:ru)
      #   (Time.now - 23).human_ago                 #=> "23 секунды назад"
      #   (Time.now - 24553).human_ago(false)       #=> 6 часов 49 минут"
      #   Time.now.human_ago                        #=> "сейчас"
      def human_ago(ago = true)
        ::StTools::Human.human_ago(self, ago)
      end

    end
  end
end
