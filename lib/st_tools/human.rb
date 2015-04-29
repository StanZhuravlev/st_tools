module StTools
  class Human

    # Функция возвращает форматированную строку из любого числа с объемом памяти.
    #
    # @param [Integer] val значение в байтах
    # @return [String] строка вида "512,4 Мбайт"
    def self.bytes(val)
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

    # Функция возвращает форматированную строку с объемом памяти, занимаемым текущим процессом (pid).
    #
    # @return [String] строка вида "512,4 Мбайт"
    def self.memory
      val = ::StTools::System.memory
      return self.bytes(val)
    end

    # Функция переводит DateTime в строку на русском или иных языках вида "4 дня 23 часа назад".
    # Предварительно необходимо вызвать StTools.setup(:ru).
    #
    # @param [DateTime] time время и дата
    # @param [Boolean] ago добавление слова "назад" в конец строки
    # @return [String] строка вида "3 дня 12 часов" или "3 дня 12 часов назад"
    def self.ago_in_words(time, ago = true)
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

    # Функция переводит DateTime в строку на русском или иных языках. Предварительно необходимо вызвать
    # StTools.setup(:ru).
    #
    # @param [DateTime] time время и дата
    # @param [Sym] type формат возвращаемого результата
    # @option :full форматирует дату и время (по умолчанию)
    # @option :date форматирует только дату
    # @option :time форматирует только время
    # @return [String] строка с форматированными датой и временем
    def self.format_time(time, what, type)
      if [:full, :date, :time].include?(what) == false
        warn "WARNING: what ':#{what.to_s}' must be in [:full, :date, :time]. Use ':full' now (at line #{__LINE__} of StTools::#{File.basename(__FILE__)})"
        what = :full
      end
      return I18n.l(time, :format => "#{what.to_s}_#{type.to_s}".to_sym)
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
