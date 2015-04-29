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

### StTools::Human

Вы вызываете в любой момент StTools::Human.memory и узнаете текущий размер памяти, занимаемый приложением (процессом)

```ruby
StTools.Human.memory               № => 14 кбайт
StTools.Human.memory               № => 45,3 Мбайт
StTools.Human.memory               № => 2,6 Гбайт
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
