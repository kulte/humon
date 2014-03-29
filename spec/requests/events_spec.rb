require 'spec_helper'

describe 'GET /events/:id' do
  it 'returns an event by :id' do
    event = create(:event)

    get "/events/#{event.id}"

    expect(response_json).to eq(
      {
        'id' => event.id,
        'address' => event.address,
        'ended_at' => event.ended_at.iso8601(3),
        'lat' => event.lat,
        'lng' => event.lng,
        'name' => event.name,
        'started_at' => event.started_at.iso8601(3),
        'owner' => {
          'device_token' => event.owner.device_token
        }
      }
    )
  end

  describe 'POST /events' do
    it 'saves the address, lat, lng, name and started_at date' do
      date =  Date.today.to_datetime
      device_token = '123abcd456xyz'
      owner = create(:user, device_token: device_token)

      post '/events', {
        address: '123 Example St.',
        ended_at: date,
        lat: 1.0,
        lng: 1.0,
        name: 'Fun Place!!',
        started_at: date,
        owner: {
          device_token: device_token
        }
      }.to_json, { 'Content-Type' => 'application/json' }

      event = Event.last
      expect(response_json).to eq({ 'id' => event.id })
      expect(event.address).to eq '123 Example St.'
      expect(event.ended_at).to eq date
      expect(event.lat).to eq 1.0
      expect(event.lng).to eq 1.0
      expect(event.name).to eq 'Fun Place!!'
      expect(event.started_at).to eq date
      expect(event.owner).to eq owner
    end
  end

  describe 'PATCH /events/:id' do
    it 'updates the event attributes' do
      event = create(:event, name: 'Old name')
      new_name = 'New name'

      patch "/events/#{event.id}", {
        address: event.address,
        ended_at: event.ended_at,
        lat: event.lat,
        lng: event.lng,
        name: new_name,
        owner: {
          device_token: event.owner.device_token
        },
        started_at: event.started_at
      }.to_json, { 'Content-Type' => 'application/json' }

      event = Event.last
      expect(event.name).to eq new_name
      expect(response_json).to eq({ 'id' => event.id })
    end
  end

  describe 'GET /events/nearest?lat=&lng=&radius=' do
    it 'returns the events closest to the lat and lng' do
      near_event = create(:event, lat: 37.760322, lng: -122.429667)
      farther_event = create(:event, lat: 37.760321, lng: -122.429667)
      create(:event, lat: 37.687737, lng: -122.470608)
      lat = 37.771098
      lng = -122.430782
      radius = 5

      get "/events/nearest?lat=#{lat}&lng=#{lng}&radius=#{radius}"

      expect(response_json).to eq([
        {
          'id' => near_event.id,
          'address' => near_event.address,
          'ended_at' => near_event.ended_at.iso8601(3),
          'lat' => near_event.lat,
          'lng' => near_event.lng,
          'name' => near_event.name,
          'owner' => { 'device_token' => near_event.owner.name },
          'started_at' => near_event.started_at.iso8601(3)
        },
        {
          'id' => farther_event.id,
          'address' => farther_event.address,
          'ended_at' => farther_event.ended_at.iso8601(3),
          'lat' => farther_event.lat,
          'lng' => farther_event.lng,
          'name' => farther_event.name,
          'owner' => { 'device_token' => farther_event.owner.name },
          'started_at' => farther_event.started_at.iso8601(3)
        }
      ])
    end
  end
end
