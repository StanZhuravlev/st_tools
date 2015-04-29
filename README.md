# StTools

Данные гем содержит методы, обеспечивающие:
- преобразование строк с учетом русского языка
- формирования человеко-удобной информации
- получения разных системных характеристик CLI-приложений
- управление прогресс-баром CLI-приложений

## Установка

Добавить в Gemfile:

```ruby
gem 'st_tools'
```

Установите гем cредствами Bundler:

    $ bundle

Или установите его отдельно:

    $ gem install st_tools

# Зависимости

Для работы гема требуется Ruby не младше версии 2.0.0. StTools не привязана к Rails и может использоваться в CLI-приложениях.
 Класс StTools::ProgressBar является надстройкой над гемом 'progressbar-ruby'.

## Использование

Часть методов библиотеки поддерживают русскую и английскую локализацию.
Поскольку все методы StTools могут вызываться без создания класса - конструктор не вызывается.
Поэтому перед работой библиотеки рекомендуется вызвать StTools::Setup.setup(:ru или :en).

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

Вы имеете возможность узнать разницу между текущим временем и временем какого-либо события.

```ruby
StTools::Setup.setup(:ru)
StTools.Human.ago_in_words(DateTime.new(2014,12,31), true)        # => 4 месяца 21 день назад
StTools.Human.ago_in_words(DateTime.new(2013,08,01), false)       # => 1 год 8 месяца
StTools.Human.ago_in_words(Time.now - 15, true)                   # => 15 секунд назад
```

```ruby
StTools::Setup.setup(:en)
StTools.Human.ago_in_words(DateTime.new(2014,12,31), true)        # => 4 months 21 days ago
StTools.Human.ago_in_words(DateTime.new(2013,08,01), false)       # => 1 year 8 months
StTools.Human.ago_in_words(Time.now - 15, true)                   # => 15 seconds ago
```

Устанавливая флаг ```ago=true```, метод добавит слово "назад" или "ago" в конце фразы.

Результирующая фраза всегда состоит из одного показатели (при разнице времени событий меньше минуты) или из двух (минуты/секунды, часы/минуты, дни/часы, месяцы/дни, года/месяцы)

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

### StTools::String

### StTools::System

### StTools::ProgressBar


## Contributing

1. Fork it ( https://github.com/[my-github-username]/st_tools/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
