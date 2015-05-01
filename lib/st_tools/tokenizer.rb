module StTools
  class Tokenizer
    attr_reader :input, :result


    private


    def initialize(opts ={})
      load_socr(opts[:socr])

      init_class('')
    end

    def processing(input)
      init_class(input)
    end





    def load_socr(socr)
      if socr.nil?
        @@socr = nil
        return nil
      end

      if socr.class == Symbol
        dict = ::YAML.load_file(__dir__ + "/../socr/#{socr.to_s.downcase}.yml")
      else
        dict = socr
      end
      dict = Hash[dict.map { |k, v| [k.to_sym, v] }]

      # Валидация списка сокращений
      raise "ОШИБКА: словарь сокращений не имеет секции :startend" if dict[:startend].nil?
      raise "ОШИБКА: словарь сокращений не имеет секции :synonyms" if dict[:synonyms].nil?

      @@socr = dict
    end

    def socr_part_processing(voc, words)
      if words[0].nil? == false && words[1].nil?
        return words.shift
      end
      return '' if words[0].nil?

      voc.each do |etalon|
        if etalon.match(/^#{words[0]}/) && etalon.match(/#{words[1]}$/)
          words.shift
          words.shift
          return etalon
        end
      end
      words.shift
    end

    def socr_one_processing(word)
      out = Array.new
      arr = word.split(/[\-\/]/)
      voc = @@socr[:startend]

      count = arr.count
      0.upto(count) do
        out << socr_part_processing(voc, arr)
      end

      out.count == 0 ? arr : out
    end

    def socr_synonyms_processing(word)
      @@socr[:synonyms][word] || word
    end

    def socr_processing(arr)
      if @@socr.nil?
        arr = arr.join(' ').gsub(/\-/, ' ').split(/\s/)
      else
        out = Array.new
        arr.each do |word|
          if word.match(/[\-\/]/)
            out += socr_one_processing(word)
          else
            out << socr_synonyms_processing(word)
          end
        end
        arr = out
      end
      return arr
    end

    def init_class(input)
      @input = input
      @tokens = Array.new

      tmp = StTools::String.normalize(input).gsub(/\-\s{1,100}/, '-').gsub(/\s{1,100}\-/, '-')
                .gsub(/\/\s{1,100}/, '/').gsub(/\s{1,100}\//, '/')
      tmp = tmp.split(/[\s\,\.\_\(\)]/)
      tmp = socr_processing(tmp)
      tmp.delete_if { |x| x == '' }

      @result = tmp
    end

  end
end