# json.array! @transactions, partial: "transactions/transaction", as: :transaction
json.transactions @transactions do |transaction|
  json.type transaction.type
  json.category transaction.category
  json.type transaction.type
  json.transfer_to_type transaction.transfer_to_type
  json.transfer_from_type transaction.transfer_from_type
  json.amount transaction.amount
  json.date transaction.date
  json.created_at transaction.created_at
end