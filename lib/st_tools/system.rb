module StTools
  class System

    # Метод возвращает размер памяти, занятой приложением
    #
    # @return [Integer] размер памяти в байтах
    def self.memory
      return `ps -o rss -p #{Process::pid}`.chomp.split("\n").last.strip.to_i
    end

    # Метод возвращает размер терминала - число строк в терминале или число символов в строке
    #
    # @param [Sym] size возвращаемый параметр
    # @option size [Sym] :width вернуть число символов в строке терминала
    # @option size [Sym] :height верунть число строк в терминале
    # @return [Integer] число символов в строке терминала или число строк в терминале
    def self.screen(size)
      sizes = `stty size 2>/dev/null`.chomp.split(' ')
      raise if sizes.count == 0
      raise if sizes.first.match(/\d/).nil?
      return sizes.last.to_i if size == :width
      return sizes.first.to_i if size == :height
    rescue
      return (size == :width) ? 100 : 25
    end

    # Метод возвращает имя запускаемого скрипта (без пути), независимо от того, откуда данный метод вызывается.
    #
    # @return [String] имя скрипта или nil в случае ошибки
    def self.exename
      res = `ps -ef | grep #{Process.pid}`
      lines = res.split(/[\r\n]/)
      lines.each do |one|
        res = one unless one.match(/grep/)
      end
      res = res.split(/\d{1,2}\:\d{1,2}\.\d{0,100}/).last
      res = File.basename(res)
      res.split(' ').first
    end

  end
end
