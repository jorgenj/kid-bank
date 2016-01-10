json.array!(@journals) do |journal|
  json.extract! journal, :id, :type
  json.url journal_url(journal, format: :json)
end
