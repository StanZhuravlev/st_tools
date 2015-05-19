module StTools
  class String

    # Метод преобразует текст в транслит
    #
    # @param [String] text исходная строка с русскими буквами
    # @return [String] строка в транслите
    # @example Примеры использования
    #   StTools::String.translit("Жмеринка")   #=> "Zhmerinka"
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

    # Метод преобразует строку в нижний регистр с одновременной заменой буквы 'ё' на 'е'.
    # Метод имеет примерно в два раза более высокую производительности по сравнению с традиционным .mb_chars.downcase.to_s,
    # но имеет ограничение - работа только с русскими и английскими строками
    #
    # @param [String] text строка в произвольном регистре
    # @return [String] строка в нижнем регистре
    # @example Примеры использования
    #   StTools::String.downcase("Hello, Вася!")   #=> "hello, вася!"
    def self.downcase(text)
      return nil if text.nil?
      return text.tr('QWERTYUIOPASDFGHJKLZXCVBNMАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ',
                     'qwertyuiopasdfghjklzxcvbnmабвгдеёжзийклмнопрстуфхцчшщъыьэюя').gsub('ё', 'е')
    end

    # Метод преобразует строку в верхний регистр с одновременной заменой буквы 'Ё' на 'Е'.
    # Метод имеет примерно в два раза более высокую производительности по сравнению с традиционным .mb_chars.downcase.to_s,
    # но имеет ограничение - работа только с русскими и английскими строками
    #
    # @param [String] text строка в произвольном регистре
    # @return [String] строка в верхнем регистре
    # @example Примеры использования
    #   StTools::String.upcase("Hello, Вася!")   #=> "HELLO, ВАСЯ!"
    def self.upcase(text)
      return nil if text.nil?
      return text.tr('qwertyuiopasdfghjklzxcvbnmабвгдеёжзийклмнопрстуфхцчшщъыьэюя',
                     'QWERTYUIOPASDFGHJKLZXCVBNMАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ').gsub('Ё', 'Е')
    end

    # Метод заменяет в исходной строке английские символы, похожие
    # на русские - на соответстующие русские символы. То есть это похоже на ситуацию,
    # когда Google меняет слово, случайно написанное английскими буквами - на русское слово. Одновременно
    # буква 'ё' меняется на 'е'.
    #
    # @param [String] text текст со смесью английских и русских букв
    # @return [String] текст только с русскими буквами
    def self.delat(text)
      return nil if text.nil?
      return text.tr('ёЁEeHCcTOoPpAHKXxBM', 'еЕЕеНСсТОоРрАНКХхВМ')
    end

    # Метод проводит нормализацию строки для последующей машиной обработки. При этом осуществляется:
    # - убирается букву 'ё'
    # - перевод строку в нижний регистр
    # - замена случайно введенных английских букв на русские
    # - убираются лидирующие и завершающие пробелы
    # - в строке удаляются повторные пробелы между словами
    #
    # @param [String] text строка, введенная пользователям
    # @return [String] строка без 'ё', в нижнем регистре, без английских букв
    # @example Примеры использования
    #   StTools::String.normalize("  Ёлки-     ПАЛКИ")   #=> "елки- палки"
    def self.normalize(text)
      return nil if text.nil?
      return self.downcase(self.delat(text)).strip.gsub(/\s{1,100}/, ' ')
    end

    # Метод позволяет показывать клиенту строку в неполном объеме, с закрытием части символов в строке звездочкой.
    # При этом число звездочек в строке определеяется ее длиной. Чем строка дилинее - тем больше в ней звездочек.
    #
    # @param [String] text строка, которую необходимо закрыть звездочками
    # @return [String] строка, часть символов которой заменена звездочками
    # @example Примеры использования
    #   StTools::String.hide("мы")                          #=> "мы"
    #   StTools::String.hide("москва")                      #=> "мо*ква"
    #   StTools::String.hide("длиннаяфраза")                #=> "дли**аяфраза"
    #   StTools::String.hide("просто произвольная фраза")   #=> "**осто пр*извол*н*я фраза"
    def self.hide(text)
      return nil if text.nil?
      len = text.length - 3
      0.upto((len/4).to_i) do
        pos = rand(len)
        text[pos,1] = '*'
      end
      return text
    end

    # Метод аналогичен обычной функции split, однако дополнительно может выполнять следующие действия:
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
    # @example Примеры использования
    #   StTools::String.split("саша, Паша,   ТАНЯ, Алина", ',')                                                 #=> ["саша", "Паша", "ТАНЯ", "Алина"]
    #   StTools::String.split("саша, Паша,   ТАНЯ, Алина", ',', normalize: true)                                #=> ["саша", "паша", "таня", "алина"]
    #   StTools::String.split("саша, Паша,   ТАНЯ, Алина", ',', normalize: true, sort: true)                    #=> ["алина", "паша", "саша", "таня"]
    #   StTools::String.split("саша, Паша,   ТАНЯ, Алина,  таня", ',', normalize: true, sort: true, uniq: true) #=> ["алина", "паша", "саша", "таня"]
    def self.split(text, separator, opts = {})
      return [] if text.nil?
      out = text.split(separator)
      out.map! { |x| x.strip }
      out.map! { |x| self.normalize(x) } if opts[:normalize]
      out.uniq! if opts[:uniq]
      out.sort! if opts[:sort]

      return out
    rescue
      return []
    end

    # Метод возвращает полный массив Array [1, 4, 5, 6, 7, 456] для строк вида '1, 4, 5-7, 456'.
    # Дополнительно осуществляется:
    # - сортировка в прямом порядке
    # - удаление дубликотов
    #
    # @param [String] text исходная строка
    # @param [Hash] opts
    # @option opts [Boolean] :sort - сортировать выходной массив
    # @option opts [Boolean] :uniq - удалить из массива дубликаты
    # @return [Array] массив чисел
    # @example Примеры использования
    #   StTools::String.to_range("1, 4, 5-7, 456, 6")                           #=> [1, 4, 5, 6, 7, 456, 6]
    #   StTools::String.to_range("1, 4, 5-7, 456, 6", sort: true)               #=> [1, 4, 5, 6, 6, 7, 456]
    #   StTools::String.to_range("1, 4, 5-7, 456, 6", sort: true, uniq: true)   #=> [1, 4, 5, 6, 7, 456]
    def self.to_range(text, opts = {})
      return [] if text.nil?
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

    # Метод делает заглавной первую букву в словах, разделенных пробелами или дефисом.
    #
    # @param [String] text исходная строка
    # @return [String] строка с первыми заглавными буквами
    # @example Примеры использования
    #   StTools::String.caps("саНКТ-петеРБург")    #=> "Санкт-Петербург"
    def self.caps(text)
      return nil if text.nil?
      str = self.downcase(text)
      str.gsub!(/(^[а-яa-z]|[а-яa-z\s]-[а-яa-z]|[\.\s\_][а-яa-z])/) do |part|
        part.gsub(/.\b$/) { |x| self.upcase(x) }
      end
      return str
    rescue
      return text
    end

    # Метод конвертирует строку в тип boolean
    #
    # @param [String] text исходная строка, содержащая 'true/false', 'on/off', '1/0'
    # @return [Boolean] true или false
    # @example Примеры использования
    #   StTools::String.to_bool("True")    #=> true
    #   StTools::String.to_bool("trUE")    #=> true
    #   StTools::String.to_bool("on")      #=> true
    #   StTools::String.to_bool("1")       #=> true
    #   StTools::String.to_bool("Да")      #=> true
    #   StTools::String.to_bool("Yes")     #=> true
    #   StTools::String.to_bool("false")   #=> false
    #   StTools::String.to_bool("fALse")   #=> false
    #   StTools::String.to_bool("oFF")     #=> false
    #   StTools::String.to_bool("0")       #=> false
    def self.to_bool(text)
      return false if text.nil?
      return true if ['true', 'on', '1', 'да', 'yes'].include?(self.downcase(text.to_s))
      false
    end

  end
end
