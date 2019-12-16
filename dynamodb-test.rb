require "aws-sdk-dynamodb"
require 'time'
dynamodb = Aws::DynamoDB::Client.new()
id = 0
opt_times = []

def gen_random(lenght=50)
  o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
  string = (0...lenght).map { o[rand(o.length)] }.join
  return string
end

while id < 100
  begin
  start_time = Time.now
  resp = dynamodb.put_item({
    item: {
      "id": "id-#{id}",
      "test": gen_random(100)
    },
    return_consumed_capacity: "TOTAL",
    table_name: "latency-test",
  })
  end_time = Time.now
  opt_times << end_time - start_time
  puts "writing id-#{id}"
  rescue StandardError => msg
    puts msg
  end
  id += 1
end
puts "all time: #{opt_times}"
puts "max: #{opt_times.max}, min: #{opt_times.min}, avg: #{opt_times.sum / opt_times.length}"
