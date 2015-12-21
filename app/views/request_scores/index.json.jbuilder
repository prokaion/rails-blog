json.array!(@request_scores) do |request_score|
  json.extract! request_score, :id, :ip, :request_count
  json.url request_score_url(request_score, format: :json)
end
