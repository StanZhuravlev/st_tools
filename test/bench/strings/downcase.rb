require "st_tools"

input = "Слово о полку ИГОРЕВЕ (Slovo O POLKU IGOREVE)"
count = 50_000
total = 5

def test_st_tools(str, count)
  started_at = Time.now.to_f
  count.times do
    StTools::String.downcase(str)
  end
  executed_at = Time.now.to_f - started_at
  speed = count.to_f / executed_at
  puts "Executed at: #{executed_at.round(3)} sec (speed = #{speed.round(1)} ops/sec)"
  speed
end


avg = 0
puts "StTools::Strings.downcase"
total.times do
  avg += test_st_tools(input, count)
end
puts "------------------------------------------------------"
puts "Average speed = #{(avg.to_f / total).round(1)} ops/sec"
puts



