module StTools
  class String

    # Функция преобразует текст в транслит
    #
    # @param [String] text исходная строка с русскими буквами
    # @return [String] строка в транслите
    def self.translit(text)
      return nil if text.nil?
      translited = text.tr('абвгдеёзийклмнопрстуфхэыь', 'abvgdeezijklmnoprstufhey\'\'')
      translited = translited.tr('АБВГДЕЁЗИЙКЛМНОПРСТУФХЭЫЬ', 'ABVGDEEZIJKLMNOPRSTUFHEY\'\'')

      translited = translited.gsub(/[жцчшщъюяЖЦЧШЩЪЮЯ]/, 'ж' => 'zh', 'ц' => 'ts', 'ч' => 'ch', 'ш' => 'sh', 'щ' => 'sch',
                                   'ъ' => '', 'ю' => 'ju', 'я' => 'ja',
                                   'Ж' => 'Zh', 'Ц' => 'Ts', 'Ч' => 'Ch', 'Ш' => 'Sh', 'Щ' => 'Sch',
                                   'Ъ' => '', 'Ю' => 'Ju', 'Я' => 'Ja')
      translited.gsub!('\'', '')
      return translited
    end

    # Функция с хорошей производительностью преобразует строку в нижний регистр.
    # Одновременно буква 'ё' замещается на 'е'
    #
    # @param [String] text строка в произвольном регистре
    # @return [String] строка в нижнем регистре
    def self.downcase(text)
      return nil if text.nil?
      return text.tr('QWERTYUIOPASDFGHJKLZXCVBNMАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ',
                     'qwertyuiopasdfghjklzxcvbnmабвгдеёжзийклмнопрстуфхцчшщъыьэюя').gsub('ё', 'е')
    end

    # Функция с хорошей производительностью преобразует строку в верхний регистр.
    # Одновременно буква 'Ё' замещается на 'Е'
    #
    # @param [String] text строка в произвольном регистре
    # @return [String] строка в нижнем регистре
    def self.upcase(text)
      return nil if text.nil?
      return text.tr('qwertyuiopasdfghjklzxcvbnmабвгдеёжзийклмнопрстуфхцчшщъыьэюя',
                     'QWERTYUIOPASDFGHJKLZXCVBNMАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ').gsub('Ё', 'Е')
    end

    # Функция заменяет в исходной строке символы английские, но похожие
    # на русские на соответстующие русские. То есть это похоже на ситуацию,
    # когда Google меняет случайно написанное английскими буквами на русское
    #
    # @param [String] text текст со смесью английских и русских букв
    # @return [String] текст только с русскими буквами
    def self.delat(text)
      return nil if text.nil?
      return text.tr('ёЁEeHCcTOoPpAHKXxBM', 'еЕЕеНСсТОоРрАНКХхВМ')
    end

    # Данную функцию рекомендуется вызывать каждый раз, как юзер вводит текст,
    # для того, чтобы:
    # - убрать букву 'ё'
    # - перевести строку в нижний регистр
    # - заменить случайно введенные английские буквы на русские
    # - убрать лидирующие и завершающие пробелы
    # - оставить в строке только один пробел между слов
    #
    # @param [String] text строка, введенная пользователям
    # @return [String] строка без 'ё', в нижнем регистре, без английских букв
    def self.normalize(text)
      return nil if text.nil?
      return self.downcase(self.delat(text)).strip.gsub(/\s{1,100}/, ' ')
    end

    # Для целей выдачи информации клиенту в неполном объеме, данная функция позволяет
    # закрыть часть строки звездочками. При этом число звездочек в строке определеяется
    # ее длиной. Чем строка дилинее - тем больше в ней звездочек
    #
    # @param [String] text строка, которую необходимо закрыть звездочками
    # @return [String] строка, часть символов которой заменена звездочками
    def self.hide_text(text)
      return nil if text.nil?
      len = text.length - 3
      0.upto((len/4).to_i) do
        pos = rand(len)
        text[pos,1] = '*'
      end
      return text
    end

    # Функция аналогична обычной функции split, однако дополнительно может выполнять следующие действия
    # - strip каждого элемента
    # - normalize соответсвующей функцией (#normalize)
    # - сортировка в прямом порядке
    # - удаление дубликотов
    #
    # @param [String] text исходная строка
    # @param [String] separator сепаратор (по умолчанию нет - необходимо явное указание)
    # @param [Hash] opts опции преобразования
    # @option opts [Boolean] :normalize - применить к каждому элементу массива функцию #normalize
    # @option opts [Boolean] :sort - сортировать выходной массив
    # @option opts [Boolean] :uniq - удалить из массива дубликаты
    # @return [Array] массив элементов из строки
    def self.split(text, separator, opts = {})
      return nil if text.nil?
      out = text.split(separator)
      out.map! { |x| x.strip }
      out.map! { |x| self.normalize(x) } if opts[:normalize]
      out.uniq! if opts[:uniq]
      out.sort! if opts[:sort]

      return out
    rescue
      return []
    end

    # Функция возвращает полный массив Array [1, 4, 5, 6, 7, 456] для строк вида '1, 4, 5-7, 456'.
    # Дополнительно осуществляется:
    # - сортировка в прямом порядке
    # - удаление дубликотов
    #
    # @param [String] text исходная строка
    # @param [Hash] opts
    # @option opts [Boolean] :sort - сортировать выходной массив
    # @option opts [Boolean] :uniq - удалить из массива дубликаты
    # @return [Array] массив чисел
    def self.to_range(text, opts = {})
      return nil if text.nil?
      out = Array.new

      tmp = self.split(text, ',')
      tmp.each do |one|
        if one.match(/\-/)
          d = one.split(/\-/)
          out += Range.new(d.first.to_i, d.last.to_i).to_a
        else
          out << one.to_i
        end
      end

      out.uniq! if opts[:uniq]
      out.sort! if opts[:sort]

      return out
    end

    # Функция делает заглавной первую букву в словах, разделенных пробелами или тире.
    # Подключеие ActiveSupport не требуется
    #
    # @param [String] text исходная строка
    # @return [String] строка с первыми заглавными буквами
    def self.caps(text)
      return nil if text.nil?
      str = self.downcase(text).split(/[\-\s]/).map { |x| self.upcase(x[0]) + x[1,x.length] }
      str = str.join(' ')
      for i in 0..str.length
        str[i] = '-' if (text.to_s[i,1] == '-')
      end

      return str
    rescue
      return text
    end

    # Функция формирует boolean значение из строки
    #
    # @param [String] text исходная строка, содержащая 'true/false', 'on/off', '1/0'
    # @return [Boolean] true или false
    def self.to_bool(text)
      return false if text.nil?
      return true if ['true', 'on', '1'].include?(self.downcase(text.to_s))
      false
    end

  end
end
