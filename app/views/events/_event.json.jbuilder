json.cache! event do
  json.id event.id
  json.address event.address
  json.ended_at event.ended_at
  json.lat event.lat
  json.lng event.lng
  json.name event.name
  json.started_at event.started_at

  json.owner do
    json.device_token event.owner.device_token
  end
end
