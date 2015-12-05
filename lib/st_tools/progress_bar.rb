module StTools
  class ProgressBar
    # Количество вызовов метода progress=.
    attr_reader :usage
    # Текущее значение прогресс-бара
    attr_reader :progress
    # Время выполнения всей операции в секундах (формируется после достижения max)
    attr_reader :executed_at
    # Максимальное значение прогресс-бара
    attr_reader :max

    # Инициализация прогресс-бара
    #
    # @param [Hash] opts параметры настройки прогресс-бара
    # @option opts [String] :title заголовок прогресс-бара
    # @option opts [Integer] :max максимальное значение
    # @option opts [Integer] :progress текущее значение (по умолчанию 0)
    # @option opts [String] :footer резюмирующая строка. Допускает два шаблона: [memory] и [executed_at], например:
    #   "Завершено за [executed_at] секунд. Занятая память [memory]"
    # @option opts [Integer] :step шаг кратно которому реально перерисовывается прогресс-бар
    # @return [Object] нет
    def initialize(opts = {})
      @title = opts[:title] || ''
      @max = opts[:max] || 100
      @progress = opts[:progress] || 0
      @footer = opts[:footer] || ''
      @step = opts[:step] || 100

      @usage = 1
      @executed_at = 0
      @start_at = ::Time.now

      init_progress_bar
    end

    # Метод устанавливает новое значение прогресс-бара
    #
    # @param [Integer] val новое значение прогресс-бара. Если равно max - то вызывается функция вывода футера
    # @return [Object] нет
    def progress=(val)
      return if val > @max
      return if val == @value
      return if val % @step != 0 && (@max - val) >= @step

      @progress = val
      @pbar.progress = val
      @usage += 1

      if val >= @max
        puts_footer
      end
    end

    # Метод финализирует значение прогресс-бара
    #
    # @return [Object] нет
    def complete
      @pbar.progress = @max if @pbar.progress < @max
    end

    private


    def init_progress_bar
      puts @title if @title != ''

      @pbar = ::ProgressBar.create(:starting_at => 0, :total => @max, :progress_mark => '=',
                                   :format => "%a |%B| %E", :throttle_rate => 1, :remainder_mark => '.')
    end

    def puts_footer
      @executed_at = (::Time.now - @start_at).to_f

      return if @footer == ''

      @executed_at_txt = @executed_at.to_s
      @executed_at_txt = @executed_at.round(1).to_s if @executed_at < 60
      @executed_at_txt = @executed_at.round(5).to_s if @executed_at < 1

      @footer.gsub!(/\[memory\]/i, ::StTools::Human.memory) if @footer.match(/\[memory\]/i)
      @footer.gsub!(/\[executed_at\]/i, @executed_at_txt) if @footer.match(/\[executed_at\]/i)

      puts @footer
    end


  end
end
