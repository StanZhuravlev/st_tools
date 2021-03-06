module StTools
  module Module
    module String

      # Метод проводит транслитерацию русского текста
      #
      # @return [String] транслитерированная строка
      def translit
        ::StTools::String.translit(self)
      end

      # Метод заменяет случайно набранные английские символы (с, р, y) в соответствующие по написанию русские
      #
      # @return [String] строка, в которой случайно набранные английские символы заменены на русские
      def delat
        ::StTools::String.delat(self)
      end

      # Метод переводит русскую и английскую строку в нижний регистр без
      # использования MultiByte (только UTF-8)
      #
      # @return [String] строка в нижнем регистре
      # @example Перевод строки в нижний регистр
      #   "Владимир".upcase #=> "владимир"
      def downcase
        ::StTools::String.downcase(self)
      end

      # Метод переводит русскую и английскую строку в верхний регистр без
      # использования MultiByte (только UTF-8)
      #
      # @return [String] строка в верхнем регистре
      # @example Перевод строки в верхний регистр
      #   "Владимир".upcase #=> "ВЛАДИМИР"
      def upcase
        ::StTools::String.upcase(self)
      end

      # Метод удаляет пробелы в начале и конце строки, проводит #delat, #downcase
      #
      # @return [String] нормализованная строка
      # @example Нормализация строки
      #   "   Владимир".normalize #=> "владимир"
      def normalize
        ::StTools::String.normalize(self)
      end

      # Метод заменяет часть символов строки на звездочки
      #
      # @return [String] строка, в которой часть букв заменены на звездочки (случайным образом)
      # @example Сокрытие части строки
      #   "Владимир".hide #=> "Вл*ди*ир"
      def hide
        ::StTools::String.hide(self)
      end

      # Метод разделяет строку на подстроки, и нормализует кажду подстроку через #normalize
      #
      # @param [String] separator строка-разделитель
      # @param [Hash] opts - массив параметров вызова метода
      # @option opts [Boolean] :sort - сортировать результирующий массив
      # @option opts [Boolean] :uniq - удалить из результирующего массива дубликаты
      # @return [Array] массив чисел
      # @example Преобразование строки в массив чисел
      #   "Москва , Питер , Владимир".split(",") #=> ['москва', 'питер', 'владимир']
      def st_split(separator, opts = {})
        ::StTools::String.split(self, separator, opts)
      end

      # Метод переводит введенные человеком цифры, перечисленные через запятую и тире
      # в массив чисел
      #
      # @param [Hash] opts
      # @option opts [Boolean] :sort - сортировать результирующий массив
      # @option opts [Boolean] :uniq - удалить из результирующего массива дубликаты
      # @return [Array] массив чисел
      # @example Преобразование строки в массив чисел
      #   "6, 3, 8-10, 1".to_range #=> [6, 3, 8, 9, 10, 1]
      #   "6, 3, 8-10".to_range(sort: true) #=> [1, 3, 6, 8, 9, 10]
      def to_range(opts = {})
        ::StTools::String.to_range(self, opts)
      end

      # Метод делает строку downcase но каждую букву каждого слова - заглавной
      #
      # @return [String] преобразованная строка
      # @example Капитализация первых букв строки
      #   "саН-франЦИСКО".caps #=> "Сан-Франциско"
      def caps
        ::StTools::String.caps(self)
      end

      # Метод обрезает строку и добавляет в случае обрезнаия многоточие
      #
      # @return [String] сокращенная строка строка
      # @example Обрезание строки
      #   "1234567890".prune(20)                  #=> "1234567890"
      #   "1234567890".prune(8)                   #=> "12345..."
      #   "1234567890".prune(8, endwidth: '---')  #=> "12345---"
      #   "Привет мир!".prune(12)                 #=> "Привет ми..."
      #   "Привет мир!".prune(12, words: true)    #=> "Привет..."
      def prune(length, words: false, endwith: '...')
        ::StTools::String.prune(self, length, words, endwith)
      end

      # Метод преобразует строковое выражение в число с плавающей запятой. При этом метод корректно преобразует
      # числа вида "12.34" и "12,34", то есть с точкой и запятой (но будет некорректный результат в случае
      # американских чисел, где запятая - разделитель тысяч, а не дробная часть).
      #
      # @param [Integer] round число цифр после запятой при округлении. По умолчанию - 6
      # @param [Object] stop если true, то при ошибке будет выброшен "Exception", иначе при ошибках будет возвращаться "0". По умолчанию - true.
      # @return [Float] число с плавающей запятой
      # @example Примеры использования
      #   '123.45678'.to_float                                 #=> 123.45678
      #   '123.474565'.to_float(round: 2)                      #=> 123.47
      #   '123,474565'.to_float(round: 2)                      #=> 123.47
      #   '   123,47456564'.to_float(round: 2)                 #=> 123.47
      #   '   10 123,47456'.to_float(round: 2)                 #=> 10123.47
      #   ' -  10 123,474565'.to_float(round: 2)               #=> -10123.47
      #   nil.to_float(round: 2) rescue 'fail'                 #=> "fail"
      #   nil.to_float(round: 2, stop: false) rescue 'fail'    #=> 0
      def to_float(round: 6, stop: true)
        ::StTools::String.to_float(self, round, stop)
      end

      # Метод переводит строку в значение boolean (true или false). True - если строка имеет одно из трех значений:
      # ['true', 'on', '1']
      #
      # @return [Boolean] true или false
      # @example проверка, что строка - true
      #   "True".to_bool #=> true
      def to_bool
        ::StTools::String.to_bool(self)
      end

      private

      # Удаляем функции downcase, upcase из оригинального класса String
      # чтобы вместо них вызывались новые функции из модуля StTools::Module::String
      # Если этого не делать, то всегда будут вызываться соответствующие методы оригинального
      # класса String
      def self.included(klass)
        klass.class_eval do
          remove_method :downcase
          remove_method :upcase
        end
      end

    end
  end
end
