module StTools
  class Common

    # Функция переводит хеши с несколькими уровнями вложения в плоский хэш, в котором
    # глубина структуры заменяется ключами, разделенными точкой.
    # За основу взят не-рекурсивный алгоритм отсюда: https://gist.github.com/lucabelmondo/4161211
    #
    # @param [Hash] hash для перевода ключей в плоский вид, разделенный точками
    # @return [Hash] возвращается одномерная Hash-структура вида "key.subkey.subsubkey" => value
    def self.flatten_hash(hash)
      result_iter = {}
      paths = hash.keys.map { |key| [key] }

      until paths.empty?
        path = paths.shift
        value = hash
        path.each { |step| value = value[step] }

        if value.respond_to?(:keys)
          value.keys.each { |key| paths << path + [key] }
        else
          result_iter[path.join(".")] = value
        end
      end

      result_iter
    end

  end
end