json.array!(@postings) do |posting|
  json.extract! posting, :id, :account_id, :journal_id, :amount
  json.url posting_url(posting, format: :json)
end
