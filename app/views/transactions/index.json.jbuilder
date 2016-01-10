json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :transaction_type, :account_id, :amount, :journal_id, :note
  json.url transaction_url(transaction, format: :json)
end
