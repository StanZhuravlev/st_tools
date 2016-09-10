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

Для работы гема требуется Ruby не младше версии 2.2.0. StTools не привязана к Rails и может использоваться в CLI-приложениях.
 Класс StTools::ProgressBar является надстройкой над гемом 'progressbar-ruby'.

## Использование

Часть методов библиотеки поддерживают русскую и английскую локализацию.
Поскольку все методы StTools могут вызываться без создания экземпляра класса - вызов конструктура класса отсутствует.
Ряд методов библиотеки требуют настройки локализации. Для этого, в приложении Ruby CLI нужно использовать:

```ruby
StTools.configure { |config| config.locale = :ru }
```

В приложении Rails необходимо создать файл `/initializers/st_tools.rb`, и включить в него:
```ruby
StTools.configure do |config|
  config.locale = :ru
end
```

### StTools::Human

Вы вызываете в любой момент StTools::Human.memory и узнаете текущий размер памяти, занимаемый приложением (процессом)

```ruby
StTools::Human.memory               # => 14 кбайт
StTools::Human.memory               # => 45,3 Мбайт
StTools::Human.memory               # => 2,6 Гбайт
```

Вы вызываете StTools::Human.bytes и перевести любое значение в человеко-удобный вид. Метод можно использовать для показа размера файла

```ruby
StTools::Human.bytes(345)           # => 345 байт
StTools::Human.bytes(14653)         # => 14,5 кбайт
StTools::Human.bytes(23653763)      # => 23,4 Мбайт
```

Вы вызываете StTools::Human.number для перевода любого значения в человеко-удобный вид.
Метод можно использовать для показа, например, суммы денег

```ruby
StTools::Human.number(345)           # => 345
StTools::Human.number(14653)         # => 14,6 тыс.
StTools::Human.number(23653763)      # => 23,7 млн.
```

Вы вызываете StTools::Human.pretty_number для красивого отображения числа с пробелами. При этом можно указать
число цифр после запятой, и автоматически конвертировать точку в звпятую

```ruby
StTools::Human.pretty_number(345)                       # => 345
StTools::Human.pretty_number(345, round: 2)             # => 345,00
StTools::Human.pretty_number(75345, round: 1)           # => 75 345,0
StTools::Human.pretty_number(nil)                       # => 0
StTools::Human.pretty_number('1675345.763', round: 1)   # => 1 675 345,7
```

Вы имеете возможность узнать разницу между текущим временем и временем какого-либо события.

```ruby 
StTools::Setup.setup(:ru)
StTools::Human.human_ago(DateTime.new(2014,12,31), true)        # => 4 месяца 21 день назад
StTools::Human.human_ago(DateTime.new(2013,08,01), false)       # => 1 год 8 месяца
StTools::Human.human_ago(Time.now - 15, true)                   # => 15 секунд назад
```

```ruby
StTools::Setup.setup(:en)
StTools::Human.human_ago(DateTime.new(2014,12,31), true)        # => 4 months 21 days ago
StTools::Human.human_ago(DateTime.new(2013,08,01), false)       # => 1 year 8 months
StTools::Human.human_ago(Time.now - 15, true)                   # => 15 seconds ago
```

Устанавливая флаг ```ago=true```, метод добавит слово "назад" или "ago" в конце фразы.

Результирующая фраза всегда состоит из одного показатели (при разнице времени событий меньше минуты)
или из двух (минуты/секунды, часы/минуты, дни/часы, месяцы/дни, года/месяцы)

Иногда возникает другой кейс, когда нужно рассчитать разницу во времени не относительно текущей даты,
а относительно любых двух произвольных событий. Для этого может использоваться метод, в который передается
не временная метка, а просто количество секунд между двумя событиями.

```ruby
StTools::Setup.setup(:ru)
StTools::Human.seconds_ago(DateTime.new(2014,12,31), true)        # => 4 months 21 days ago
StTools::Human.seconds_ago(DateTime.new(2013,08,01), false)       # => 1 year 8 months
StTools::Human.seconds_ago(Time.now - 15, true)                   # => 15 seconds ago
```


Вы имеете форматировать дату и время в соответствии с правилами русского и английского языка.

```ruby
StTools::Setup.setup(:ru)
StTools::Human.format_time(Time.now, :full, :full)              # => 28 апреля 2015 г. 10:45:23
StTools::Human.format_time(Time.now, :date, :full)              # => 28 апреля 2015 г.
StTools::Human.format_time(Time.now, :time, :full)              # => 10:45:23
StTools::Human.format_time(Time.now, :full, :short)             # => 28/04/2015 10:45
StTools::Human.format_time(Time.now, :date, :short)             # => 28/04/2015
StTools::Human.format_time(Time.now, :time, :short)             # => 10:45
```

```ruby
StTools::Setup.setup(:en)
StTools::Human.format_time(Time.now, :full, :full)              # => April 28, 2015 09:45:23 am
StTools::Human.format_time(Time.now, :date, :full)              # => April 28, 2015
StTools::Human.format_time(Time.now, :time, :full)              # => 09:45:23 am
StTools::Human.format_time(Time.now, :full, :short)             # => 04/28/2015 09:45 am
StTools::Human.format_time(Time.now, :date, :short)             # => 04/28/2015
StTools::Human.format_time(Time.now, :time, :short)             # => 09:45 am
```

Вы можете подмешать модуль `StTools::Module` в классы String, Integer, Time.

```ruby
StTools::Setup.setup(:ru)

class String
   include StTools::Module::String
end

(Time.now - 15)::Human_ago                         # => 15 секунд назад
Time.now.format_date                              # => 28 апреля 2015 г.
Time.now.format_date(:short)                      # => 28/04/2015
```

### StTools::String

#### translit

Транслитерация строки из русского на английский

```ruby
StTools::String.translit('Жмеринка')                  # => Zhmerinka
```

#### delat

Иногда пользователи вводят английские буквы, похожие на русские, чаще все - букву 'C'. Метод delat заменяет такие символы на русские

```ruby
StTools::String.delat('Соль')                         # => Соль
```

#### upcase/downcase

Перевести строку в верхний или нижний регистр. Используется метод, не использующий :mb_chars

```ruby
StTools::String.downcase('Москва')                    # => москва
StTools::String.upcase('Москва')                      # => МОСКВА
```

#### normalize

Иногда надо нормализовать строку и привести ее к виду, удобному для машинной обработки.
Метод normalize последовательно делает: `strip`, `delat`, `downcase`. Кроме того, метод корректно заменит
на обычные пробелы "короткие" пробелы, получающиеся после преобразования тега HTML `&nbsp;` в пробел. 

```ruby
StTools::String.normalize('   Москва  ')              # => "москва"
```

Внимание!!! Функцию следует использовать с осторожностью, и не забывать, что для ряда задач она не подходит. 
В частности, выполнение `StTools::String.normalize('TRUE')` даст значение `true`, в котором буква `е` будет
русская (применена функция `delat`). 

#### caps

Следующий метод приводит строку к нижнему регистру, но делает первую букву заглавной.
Удобно для нормализации имени и фамилии, вводимых пользователем

```ruby
StTools::String.caps('санКТ-петерБург')              # => "Санкт-Петербург"
StTools::String.caps('1-Я владимирская')             # => "1-я Владимирская"
StTools::String.caps('stan.zhuravlev@mail.ru')       # => "Stan.Zhuravlev@mail.Ru"
StTools::String.caps('а.с. ПУШКИН')                  # => "А.С. Пушкин"
StTools::String.caps('ivan_petrov')                  # => "Ivan_Petrov"
StTools::String.caps('н.а.римский-корсаков')         # => "Н.А.Римский-Корсаков"

StTools::String.caps('н.а.римский-корсаков пришел в гости к в.и. ленину на улицу героев 1812-го года')
  #=> "Н.А.Римский-Корсаков Пришел В Гости К В.И. Ленину На Улицу Героев 1812-го Года"
```

#### hide

Для реализации деморежимов различных приложений иногда надо скрыть реальный результат. Для это можно
использовать метод hide

```ruby
StTools::String.hide('Краснодар')              # => "Кра*но*ар"
```

#### to_bool

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

Когда в Rails-приложение передается массив params, то значение bool обычно выглдяит строкой. При этом часть значений
опциональные, то есть пользователь может не ввести его. Для этого можно использовать второй параметр функции, по
умолчанию имеющий значение false.

```
params = { opt1: true }
StTools::String.to_bool(params[:opt1], false)      #=> true
StTools::String.to_bool(params[:opt2], true)       #=> true
```

#### split

Если пользователь введет в качестве входного параметра перечисление, следующий метод разобъет его на токены,
с нормализацией при необходимости

```ruby
StTools::String.split('ТАНЯ, маша, петя', ',')                                 # => ['ТАНЯ', 'маша', 'петя']
StTools::String.split('ТАНЯ, маша, петя', ',', normalize: true)                # => ['таня', 'маша', 'петя']
StTools::String.split('ТАНЯ, маша, петя', ',', normalize: true, sort: true)    # => ['маша', 'петя', 'таня']
```

#### to_range

Если от пользователя требуется ввести численные значения в виде перечисления или диапазоне, нужно использовать
метод to_range

```ruby
StTools::String.to_range('54, 3-6, 5, 1')                                 # => [54, 3, 5, 6, 5, 1]
StTools::String.to_range('54, 3-6, 5, 1', uniq: true)                     # => [54, 3, 5, 6, 1]
StTools::String.to_range('54, 3-6, 5, 1', uniq: true, sort: true)         # => [1, 3, 5, 6, 54]
```

#### pretty_list

Следующий метод `pretty_list` позволяет сделать human-подобное оформление списков-перечислений.

```ruby
StTools::Setup.setup(:ru)
'Мы работаем ' + StTools::String.pretty_list([4,5,6]) + ' мая'
    # => "Мы работаем 4, 5 и 6 мая"
'Доехать можно на трамваях ' + StTools::String.pretty_list([67, 89], union: :or) + ' маршрутов'
    # => "Доехать можно на трамвае 67 или 89 маршрутов"
'Скидка составит ' + StTools::String.pretty_list([100, 200], union: :or, pretag: '<em>', afttag: '</em>') + ' руб.'
    # => "Скидка составит <em>100</em> или <em>200</em> руб."

StTools::Setup.setup(:en)
'Discount is ' + StTools::String.pretty_list([100, 200], union: :or, pretag: '<em>$', afttag: '</em>')
    # => "Discount is <em>$100</em> or <em>$200</em>"
```

#### prune

В ряде случаев необходимо обрезать строку таким образом, чтобы на экране уместилась часть строки, и многоточие,
которе показывает, что строка была сокращена. Для этого можно использовать метод `StTools::String.prune`.

```ruby
StTools::String.prune("1234567890", 20)                   #=> "1234567890"
StTools::String.prune("1234567890", 8)                    #=> "12345..."
StTools::String.prune("1234567890", 8, endwidth: '---')   #=> "12345---"
StTools::String.prune("Привет мир!", 12)                  #=> "Привет ми..."
StTools::String.prune("Привет мир!", 12, words: true)     #=> "Привет..."
```

Следует обратить внимание на два момента. Во-первых, строка обрезается до указанной длины ПЛЮС длина завершающего многточия.
То есть при указании `StTools::String.prune("1234567890", 5)` результат будет `"12..."`. Во-вторых, если указать параметр
`word: true`, то произойдет более "умное" обрезание фразы - не посреди слова (как показано в примере выше), а по границе
слова, то есть по пробелу между словами в меньшую сторону.

#### to_float

Метод `to_float` позволяет переводить различные строки, введенные пользователем, в тип `Float` языка Ruby.

```ruby
StTools::String.to_float('123.45678')                                 #=> 123.45678
StTools::String.to_float('123.474565', round: 2)                      #=> 123.47
StTools::String.to_float('123,474565', round: 2)                      #=> 123.47
StTools::String.to_float('   123,47456564', round: 2)                 #=> 123.47
StTools::String.to_float('   10 123,47456', round: 2)                 #=> 10123.47
StTools::String.to_float(' -  10 123,474565', round: 2)               #=> -10123.47
```

Если у Вас уже есть число в формате `Float` или `Integer`, то все равно можно вызвать метод `to_float`. При этом
произойдет только округление числа в соответствии с параметром `round`.

```ruby
StTools::String.to_float(145.5667, round: 2)                          #=> 145.57
StTools::String.to_float(23, round: 2)                                #=> 23
```

Возможны ситуации, когда параметр переданный является `nil` или строкой, не содержащей числа. В этом случае возможны
две модели поведения. Первая (установленная по умолчанию), выбрасывает Exception в случае, если переданная на вход
метода строка не содержит цифр. Другая модель предусматривает возвращаение нулевого значения при ошибке. Для этого
нужно установить параметр `stop` в значение `false`.

```ruby
StTools::String.to_float(nil) rescue 'fail')                          #=> "fail"
StTools::String.to_float(nil, stop: false) rescue 'fail')             #=> 0
StTools::String.to_float('no digits') rescue 'fail')                  #=> "fail"
StTools::String.to_float('no digits', stop: false) rescue 'fail')     #=> 0
```

#### Расширение класса String (include StTools)

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
