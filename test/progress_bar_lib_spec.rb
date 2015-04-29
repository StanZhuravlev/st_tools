require 'rspec'
require 'st_tools'

describe 'Проверка методов StTools::ProgressBar.*' do

  it 'Комплексный тест' do
    bar = ::StTools::ProgressBar.new(title: "Тестовый запуск",
                                     footer: "Занято [memory], выполнено за [executed_at] сек.",
                                     max: 10000000)
    # step - по умолчанию
    # progress не устаналиваем

    10000010.times do |val|
      bar.progress = val
    end

  end
end