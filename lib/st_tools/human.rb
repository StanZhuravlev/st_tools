module StTools
  class Human


    # Метод форматирует число, добавляя суффиксы 'тыс.', 'млн.' и пр.
    #
    # @param [Integer] val исходное числовое значение
    # @return [String] строка вида "512,4 тыс."
    # @example Примеры использования
    #   StTools::Human.number(123)           #=> "123"
    #   StTools::Human.number(14563)         #=> "14 тыс."
    #   StTools::Human.number(763552638)     #=> "763.6 млн."
    def self.number(val)
      # todo: локлаизовать через i18N
      # noinspection RubyStringKeysInHashInspection
      arr = {'' => 1000, 'тыс.' => 1000 * 1000, 'млн.' => 1000 * 1000 * 1000,
             'млрд.' => 1000 * 1000 * 1000 * 1000, 'трлн.' => 1000 * 1000 * 1000 * 1000 * 1000}

      arr.each_pair do |e, s|
        if val < s
          if ['', ' тыс.'].include?(e)
            return "#{(val.to_f / (s / 1000)).round(0)} #{e}"
          else
            return "#{(val.to_f / (s / 1000)).round(1)} #{e}"
          end
        end
      end
    end

    # Метод форматирует число, добавляя суффиксы 'кбайт', 'Мбайт' и др.
    #
    # @param [Integer] val исходное числовое значение в байтах
    # @return [String] строка вида "512,4 Мбайт"
    # @example Примеры использования
    #   StTools::Human.bytes(123)           #=> "123 байта"
    #   StTools::Human.bytes(14563)         #=> "14 кбайт"
    #   StTools::Human.bytes(763552638)     #=> "728.2 Мбайт"
    def self.bytes(val)
      # todo: локлаизовать через i18N
      # noinspection RubyStringKeysInHashInspection
      arr = {'байт' => 1024, 'кбайт' => 1024 * 1024, 'Мбайт' => 1024 * 1024 * 1024,
             'Гбайт' => 1024 * 1024 * 1024 * 1024, 'Тбайт' => 1024 * 1024 * 1024 * 1024 * 1024}

      arr.each_pair do |e, s|
        if val < s
          if %w(байт кбайт).include?(e)
            return "#{(val.to_f / (s / 1024)).round(0)} #{e}"
          else
            return "#{(val.to_f / (s / 1024)).round(1)} #{e}"
          end
        end
      end
    end

    # Метод возвращает форматированную строку с объемом памяти, занимаемым текущим процессом (pid).
    #
    # @return [String] строка вида "512,4 Мбайт"
    def self.memory
      val = ::StTools::System.memory
      return self.bytes(val)
    end

    # Метод переводит DateTime в строку на русском или иных языках вида "4 дня 23 часа назад".
    # Предварительно необходимо вызвать StTools.setup(:ru или :en).
    #
    # @param [DateTime] time время и дата
    # @param [Boolean] ago true, если надо добавить слово "назад" в конец строки
    # @return [String] строка вида "3 дня 12 часов" или "3 дня 12 часов назад"
    # @example Примеры использования
    #   StTools::Setup.setup(:ru)
    #   StTools::Human.human_ago(Time.now - 23, true)       #=> "23 секунды назад"
    #   StTools::Human.human_ago(Time.now - 24553, false)   #=> 6 часов 49 минут"
    #   StTools::Human.human_ago(Time.now)                  #=> "сейчас"
    def self.human_ago(time, ago = true)
      now = self.to_time(Time.now.strftime('%Y-%m-%d %H:%M:%S UTC'))
      slf = self.to_time(time.strftime('%Y-%m-%d %H:%M:%S UTC'))
      secs = (now - slf).to_i
      return I18n.t('common.ago.very_long') if time.year < 1800
      return I18n.t('common.ago.just_now') if secs > -1 && secs < 1
      return '' if secs <= -1
      pair = self.ago_in_words_pair(secs)
      pair << I18n.t("common.ago.ago_word") if ago == true
      pair.join(' ')
    end

    # Метод принимает параметр - количество секунд между двумя любыми событиями в секундах,
    # и переводит их в строку на русском или иных языках вида "4 дня 23 часа назад".
    # Предварительно необходимо вызвать StTools.setup(:ru или :en).
    #
    # @param [DateTime] sesc количество секунд
    # @param [Boolean] ago true, если надо добавить слово "назад" в конец строки
    # @return [String] строка вида "3 дня 12 часов" или "3 дня 12 часов назад"
    # @example Примеры использования
    #   StTools::Setup.setup(:ru)
    #   StTools::Human.seconds_ago(23, true)       #=> "23 секунды назад"
    #   StTools::Human.seconds_ago(24553, false)   #=> 6 часов 49 минут"
    #   StTools::Human.seconds_ago(0)              #=> "сейчас"
    def self.seconds_ago(secs, ago = true)
      secs_i = secs.to_i
      return I18n.t('common.ago.just_now') if secs_i > -1 && secs_i < 1
      return '' if secs_i <= -1
      pair = self.ago_in_words_pair(secs_i)
      pair << I18n.t("common.ago.ago_word") if ago == true
      pair.join(' ')
    end

    # Метод переводит DateTime в строку на русском или иных языках. Предварительно необходимо вызвать
    # StTools.setup(:ru или :en).
    #
    # @param [DateTime] time исходные время и дата
    # @param [Sym] what формат возвращаемого результата, принимает одно из следующих значений
    # @option :full форматирует дату и время (по умолчанию)
    # @option :date форматирует только дату
    # @option :time форматирует только время
    # @param [Sym] type форма в которой возращать результат: длинная ("28 апреля 2015 г. 10:34:52") или короткая ("28/04/2015 10:34")
    # @option :full длинна форма
    # @option :short короткая форма
    # @return [String] строка с форматированными датой и временем
    # @example Примеры использования
    #   StTools::Setup.setup(:ru)
    #   StTools::Human.format_time(Time.now, :full, :full)       #=> "30 апреля 2015 г. 08:54:34"
    #   StTools::Human.format_time(Time.now, :date, :full)       #=> "30 апреля 2015 г."
    #   StTools::Human.format_time(Time.now, :time, :full)       #=> "08:54:34"
    #   StTools::Human.format_time(Time.now, :full, :short)      #=> "30/04/2015 08:55"
    #   StTools::Human.format_time(Time.now, :date, :short)      #=> "30/04/2015"
    #   StTools::Human.format_time(Time.now, :time, :short)      #=> "08:55"
    def self.format_time(time, what, type)
      unless [:full, :date, :time].include?(what)
        warn "WARNING: what ':#{what.to_s}' must be in [:full, :date, :time]. Use ':full' now (at line #{__LINE__} of StTools::#{File.basename(__FILE__)})"
        what = :full
      end
      return I18n.l(time, :format => "#{what.to_s}_#{type.to_s}".to_sym)
    end


    # Метод оформляет число красивым способом, в виде "1 456 742,34".
    #
    # @param [Object] value исходное число в виде строки или числа, допустим nil
    # @param [Integer] round число цифр после запятой (по умолчанию - 0)
    # @param [Boolean] nobr обрамить результат тегами nobr (по умолчанию - false)
    # @param [Boolean] strong обрамить результат тегами strong (по умолчанию - false)
    # @return [String] строка с форматированным числом
    # @example Примеры использования
    #   StTools::Human.pretty_number(345)                       # => 345
    #   StTools::Human.pretty_number(345, round: 2)             # => 345,00
    #   StTools::Human.pretty_number(75345, round: 1)           # => 75 345,0
    #   StTools::Human.pretty_number(nil)                       # => 0
    #   StTools::Human.pretty_number('1675345.763', round: 1)   # => 1 675 345,7
    def self.pretty_number(value, round: 0, nobr: false, strong: false)
      out = StTools::String.to_float(value, round: round, stop: false).to_s
      arr = out.split(/[\,\.]/)
      tmp = arr.first.split(//).reverse.each_slice(3).to_a
      out = Array.new
      tmp.each do |one|
        out << one.reverse.join
      end
      out = out.reverse.join(' ')
      if arr.count > 1
        out = [out, (arr.last + '000000000000000')[0,round]].join(',')
      end
      out = "<nobr>#{out}</nobr>" if nobr
      out = "<strong>#{out}</strong>" if strong
      out
    end



    private




    def self.ago_in_words_pair(secs)
      mins = (secs / 60).to_i
      hours = (mins / 60).to_i
      days = (hours / 24).to_i
      years = (days / 365).to_i
      months = (days / (365/12)).to_i
      # puts "#{secs}, #{mins}, #{hours}, #{days}, #{months}, #{years}"

      return ago_in_words_one_pair(years, months - (years*12), "year", "month") if (months > 12)
      return ago_in_words_one_pair(months, days - (months*(365/12)), "month", "day") if (days > 28)
      return ago_in_words_one_pair(days, hours - (days*24), "day", "hour") if (hours > 24)
      return ago_in_words_one_pair(hours, mins - (hours*60), "hour", "minute") if (mins > 60)
      return ago_in_words_one_pair(mins, secs - (mins*60), "minute", "second") if (secs > 60)
      return [ago_in_words_one_value(secs, "second")]
    end

    def self.ago_in_words_one_pair(val1, val2, tag1, tag2)
      return [ago_in_words_one_value(val1, tag1), ago_in_words_one_value(val2, tag2)]
    end

    def self.ago_in_words_one_value(val, tag)
      num100 = val % 100
      num10 = val % 10
      return val.to_s + " " + I18n.t("common.ago.#{tag}.other") if (num100 >=5 && num100 <= 20)
      return val.to_s + " " + I18n.t("common.ago.#{tag}.one") if (num10 == 1)
      return val.to_s + " " + I18n.t("common.ago.#{tag}.two") if ([2, 3, 4].include?(num10))
      return val.to_s + " " + I18n.t("common.ago.#{tag}.other")
    end

    def self.to_time(time, form = :local)
      parts = Date._parse(time, false)
      return if parts.empty?

      now = Time.now
      time = Time.new(
          parts.fetch(:year, now.year),
          parts.fetch(:mon, now.month),
          parts.fetch(:mday, now.day),
          parts.fetch(:hour, 0),
          parts.fetch(:min, 0),
          parts.fetch(:sec, 0) + parts.fetch(:sec_fraction, 0),
          parts.fetch(:offset, form == :utc ? 0 : nil)
      )

      form == :utc ? time.utc : time.getlocal
    end

  end
end
