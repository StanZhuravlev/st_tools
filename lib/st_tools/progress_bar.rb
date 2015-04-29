module StTools
  class ProgressBar
    attr_reader :usage, :progress, :executed_at

    # Инициализация прогресс-бара
    #
    # @param [Hash] opts параметры настройки прогресс-бара
    # @option opts [String] :title заголовок прогресс-бара
    # @option opts [Integer] :max максимальное значение
    # @option opts [Integer] :progress текущее значение (по умолчанию 0)
    # @option opts [String] :footer резюмирующая строка. Допускает два шаблона: [memory] и [executed_at]
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

    # Функция устанавливает новое значение прогресс-бара
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

      if val > @max - 1
        puts_footer
      end
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

      @executed_at_txt = @executed_at.to_i
      @executed_at_txt = @executed_at.round(1).to_s if @executed_at < 60
      @executed_at_txt = @executed_at.round(5).to_s if @executed_at < 1

      @footer.gsub!(/\[memory\]/i, ::StTools::Human.memory) if @footer.match(/\[memory\]/i)
      @footer.gsub!(/\[executed_at\]/i, @executed_at_txt) if @footer.match(/\[executed_at\]/i)

      puts @footer
    end


  end
end
