require "sneakers"
Sneakers.configure(
  amqp: ENV["RABBITMQ_URL"],
  exchange: "sneakers",
  exchange_type: :direct
)

