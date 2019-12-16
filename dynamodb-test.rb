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

while true
  begin
  start_time = Time.now
  resp = dynamodb.put_item({
    item: {
      "id": "id-#{id}",
      "test-data-1": gen_random(100),
      "test-data-2": gen_random(50),
      "test-data-3": gen_random(150)
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
  if id ==300
    puts "last 300 opt time: #{opt_times}"
    puts "max: #{opt_times.max}, min: #{opt_times.min}, avg: #{opt_times.sum / opt_times.length}"
    id = 0 
    opt_times = []
  end
end