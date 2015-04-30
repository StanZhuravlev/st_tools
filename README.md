# StTools

Библиотека StTools предназначена для поддержки CLI- и Rails-приложений. Она обеспечивает
различное преобразование строк с учетом русского языка, формирование человеко-удобного представления времени и чисел,
получения разных системных характеристик CLI-приложений (память, размер экрана терминала),
управление прогресс-баром CLI-приложений.

## Установка

Добавить в Gemfile:

```ruby
gem 'st_tools'
```

Установить гем cредствами Bundler:

    $ bundle

Или установить его отдельно:

    $ gem install st_tools

# Зависимости

Для работы гема требуется Ruby не младше версии 2.0.0. StTools не привязана к Rails и может использоваться в CLI-приложениях.
 Класс StTools::ProgressBar является надстройкой над гемом 'progressbar-ruby'.

## Использование

Часть методов библиотеки поддерживают русскую и английскую локализацию.
Поскольку все методы StTools могут вызываться без создания экземпляра класса - вызов конструктура класса отсутствует.
Поэтому перед работой библиотеки рекомендуется вызвать StTools::Setup.setup(:ru или :en) для загрузки файлов локализации.

### StTools::Human

Вы вызываете в любой момент StTools::Human.memory и узнаете текущий размер памяти, занимаемый приложением (процессом)

```ruby
StTools.Human.memory               # => 14 кбайт
StTools.Human.memory               # => 45,3 Мбайт
StTools.Human.memory               # => 2,6 Гбайт
```

Вы вызываете StTools::Human.bytes и перевести любое значение в человеко-удобный вид. Метод можно использовать для показа размера файла

```ruby
StTools.Human.bytes(345)           # => 345 байт
StTools.Human.bytes(14653)         # => 14,5 кбайт
StTools.Human.bytes(23653763)      # => 23,4 Мбайт
```

Вы вызываете StTools::Human.number для перевода любого значения в человеко-удобный вид.
Метод можно использовать для показа, например, суммы денег

```ruby
StTools.Human.number(345)           # => 345
StTools.Human.number(14653)         # => 14,6 тыс.
StTools.Human.number(23653763)      # => 23,7 млн.
```

Вы имеете возможность узнать разницу между текущим временем и временем какого-либо события.

```ruby
StTools::Setup.setup(:ru)
StTools.Human.ago_in_words(DateTime.new(2014,12,31), true)        # => 4 месяца 21 день назад
StTools.Human.ago_in_words(DateTime.new(2013,08,01), false)       # => 1 год 8 месяца
StTools.Human.ago_in_words(Time.now - 15, true)                   # => 15 секунд назад
```

```ruby
StTools::Setup.setup(:en)
StTools.Human.human_ago(DateTime.new(2014,12,31), true)        # => 4 months 21 days ago
StTools.Human.human_ago(DateTime.new(2013,08,01), false)       # => 1 year 8 months
StTools.Human.human_ago(Time.now - 15, true)                   # => 15 seconds ago
```

Устанавливая флаг ```ago=true```, метод добавит слово "назад" или "ago" в конце фразы.

Результирующая фраза всегда состоит из одного показатели (при разнице времени событий меньше минуты)
или из двух (минуты/секунды, часы/минуты, дни/часы, месяцы/дни, года/месяцы)

Иногда возникает другой кейс, когда нужно рассчитать разницу во времени не относительно текущей даты,
а относительно любых двух произвольных событий. Для этого может использоваться метод, в который передается
не временная метка, а просто количество секунд между двумя событиями.

```ruby
StTools::Setup.setup(:ru)
.seconds_ago(DateTime.new(2014,12,31), true)        # => 4 months 21 days ago
StTools.Human.seconds_ago(DateTime.new(2013,08,01), false)       # => 1 year 8 months
StTools.Human.seconds_ago(Time.now - 15, true)                   # => 15 seconds ago
```


Вы имеете форматировать дату и время в соответствии с правилами русского и английского языка.

```ruby
StTools::Setup.setup(:ru)
StTools.Human.format_time(Time.now, :full, :full)              # => 28 апреля 2015 г. 10:45:23
StTools.Human.format_time(Time.now, :date, :full)              # => 28 апреля 2015 г.
StTools.Human.format_time(Time.now, :time, :full)              # => 10:45:23
StTools.Human.format_time(Time.now, :full, :short)             # => 28/04/2015 10:45
StTools.Human.format_time(Time.now, :date, :short)             # => 28/04/2015
StTools.Human.format_time(Time.now, :time, :short)             # => 10:45
```

```ruby
StTools::Setup.setup(:en)
StTools.Human.format_time(Time.now, :full, :full)              # => April 28, 2015 09:45:23 am
StTools.Human.format_time(Time.now, :date, :full)              # => April 28, 2015
StTools.Human.format_time(Time.now, :time, :full)              # => 09:45:23 am
StTools.Human.format_time(Time.now, :full, :short)             # => 04/28/2015 09:45 am
StTools.Human.format_time(Time.now, :date, :short)             # => 04/28/2015
StTools.Human.format_time(Time.now, :time, :short)             # => 09:45 am
```

Вы можете подмешать модуль `StTools::Module` в классы String, Integer, Time.

```ruby
StTools::Setup.setup(:ru)

class String
   include StTools::Module::String
end

(Time.now - 15).human_ago                         # => 15 секунд назад
Time.now.format_date                              # => 28 апреля 2015 г.
Time.now.format_date(:short)                      # => 28/04/2015
```

### StTools::String

Транслитерация строки из русского на английский

```ruby
StTools::String.translit('Жмеринка')                  # => Zhmerinka
```

Иногда пользователи вводят английские буквы, похожие на русские, чаще все - букву 'C'. Метод delat заменяет такие символы на русские

```ruby
StTools::String.delat('Соль')                         # => Соль
```

Перевести строку в верхний или нижний регистр. Используется метод, не использующий :mb_chars

```ruby
StTools::String.downcase('Москва')                    # => москва
StTools::String.upcase('Москва')                      # => МОСКВА
```

Иногда надо нормализовать строку и привести ее к виду, удобному для машинной обработки.
Метод normalize последовательно делает: strip, delat, downcase

```ruby
StTools::String.normalize('   Москва  ')              # => "москва"
```

Следующий метод приводит строку к нижнему регистру, но делает первую букву заглавной.
Удобно для нормализации имени и фамилии, вводимых пользователем

```ruby
StTools::String.caps('санКТ-петерБург')              # => "Санкт-Петербург"
```

Для реализации деморежимов различных приложений иногда надо скрыть реальный результат.
Для это можно использовать метод hide

```ruby
StTools::String.hide('Краснодар')              # => "Кра*но*ар"
```

В Ruby отсутствует метод перевода строки пользователя в тип Boolean.

```ruby
StTools::String.to_bool("True")    # => true
StTools::String.to_bool("trUE")    # => true
StTools::String.to_bool("on")      # => true
StTools::String.to_bool("1")       # => true
StTools::String.to_bool("Да")      # => true
StTools::String.to_bool("Yes")     # => true
StTools::String.to_bool("false")   # => false
StTools::String.to_bool("fALse")   # => false
StTools::String.to_bool("oFF")     # => false
StTools::String.to_bool("0")       # => false
```

Если пользователь введет в качестве входного параметра перечисление, следующий метод разобъет его на токены,
с нормализацией при необходимости

```ruby
StTools::String.split('ТАНЯ, маша, петя', ',')                                 # => ['ТАНЯ', 'маша', 'петя']
StTools::String.split('ТАНЯ, маша, петя', ',', normalize: true)                # => ['таня', 'маша', 'петя']
StTools::String.split('ТАНЯ, маша, петя', ',', normalize: true, sort: true)    # => ['маша', 'петя', 'таня']
```

Если от пользователя требуется ввести численные значения в виде перечисления или диапазоне, нужно использовать
метод to_range

```ruby
StTools::String.to_range('54, 3-6, 5, 1')                                 # => [54, 3, 5, 6, 5, 1]
StTools::String.to_range('54, 3-6, 5, 1', uniq: true)                     # => [54, 3, 5, 6, 1]
StTools::String.to_range('54, 3-6, 5, 1', uniq: true, sort: true)         # => [1, 3, 5, 6, 54]
```

Вы можете подмешать модуль `StTools::Module` в классы String, Integer, Time.

```ruby
StTools::Setup.setup(:ru)

class String
   include StTools::Module::String
end

'санКТ-петерБург'.caps                         # => Санкт-Петербург
'санКТ-петерБург'.downcase                     # => санкт-петербург
'санКТ-петерБург'.upcase                       # => САНКТ-ПЕТЕРБУРГ
'on'.to_bool                                   # => true
'34, 2-5, 8, 1'.to_range(sort: true)           # => [1, 2, 4, 5, 8, 34]
'Краснодар'.hide                               # => Кра*но*ар
```

### StTools::System

Узнать объем оперативной памяти, занятый приложением

```ruby
StTools::System.memory                                 # => 145734
```

Узнать ширину и высоту текущего окна терминала в CLI-режиме

```ruby
StTools::System.screen(:width)               # => 114
StTools::System.screen(:height)              # => 25
```

### StTools::ProgressBar

Данная бибилиотека базируется на геме 'progressbar-ruby' (https://github.com/jfelchner/ruby-progressbar), но надстройка над ним
упрощает использование библиотеки, и исключает некоторые проблемы.

Библиотека содержит две функции. Первая - инициирует начало отображения прогресс-бара

```ruby
@bar = ::StTools::ProgressBar.new(title: "Тестовый запуск",
                                  footer: "Занято [memory], выполнено за [executed_at] сек.",
                                  max: 10000000)
```

Задается заголовок, который будет отображен перед прогресс-баром. Затем указывается футер, который отобразиться как
только прогресс станет 100%. Футер содержит две шаблона:
- [memory], который будет заменен на результат вызова StTools::Human.memory
- [executed_at], который будет заменен на время в секундах завершенного процесса

Значение :max содержит финальное значение прогресса. Дополнительно рекомендуется задать значение :step, которое
показывает, на каком шаге в реальности должен меняться процент выполнения операции.

Затем, в цикле, который обеспечивает выполнение длительной операции, необходимо менять значение progress.

```ruby
10000010.times do |val|
  @bar.progress = val
end
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/st_tools/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
