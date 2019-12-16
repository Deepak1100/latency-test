require "aws-sdk-dynamodb"
require 'time'
dynamodb = Aws::DynamoDB::Client.new()
id = 0
opt_times = []
while id < 100
  begin
  start_time = Time.now
  resp = dynamodb.put_item({
    item: {
      "id": "id-#{id}",
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
