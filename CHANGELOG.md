## 0.3.4 (2015-05-01)

* Добавлено удаление функций :downcase, :upcase стандартного модуля String при подмешивании (include) StTools
* Название метода .words_in_ago изменено на .human_ago
* Добавлен метод .seconds_ago, форматирующий строку для количества секунд между событиями

## 0.3.3 (2015-04-30)

* Название метода .hide_text изменено на .hide
* Доработана документация
* Исправлены результаты работы функций .split и .to_range при передаче в них nil
* В метод .to_bool добавлены значения "да" и "yes" в качестве значений, являющихся true