SF_GEOCODE_JSON = <<-JSON
{
  "status": "OK",
  "results": [ {
    "types": ["locality", "political"],
    "formatted_address": "San Francisco, CA, USA",
    "address_components": [ {
      "long_name": "San Francisco",
      "short_name": "SF",
      "types": ["locality", "political"]
    }, {
      "long_name": "San Francisco",
      "short_name": "San Francisco",
      "types": ["administrative_area_level_2", "political"]
    }, {
      "long_name": "California",
      "short_name": "CA",
      "types": ["administrative_area_level_1", "political"]
    }, {
      "long_name": "United States",
      "short_name": "US",
      "types": ["country", "political"]
    } ],
    "geometry": {
      "bounds": {
        "northeast": {
          "lat": 37.9297707, 
          "lng": -122.3279149
        },
        "southwest": {
          "lat": 37.6933354, 
          "lng": -123.1077733
        }
      },
      "location": {
        "lat": 37.7749295,
        "lng": -122.4194155
      },
      "location_type": "APPROXIMATE",
      "viewport": {
        "southwest": {
          "lat": 37.70339999999999,
          "lng": -122.527
        },
        "northeast": {
          "lat": 37.812,
          "lng": -122.3482
        }
      }
    }
  } ]
}
JSON

FakeWeb.allow_net_connect = false

Before('@without_geocode') do
  FakeWeb.register_uri(:any, %r|http://maps\.googleapis\.com/maps/api/geocode|, :body => SF_GEOCODE_JSON)
end

Before('@javascript') do
  FakeWeb.allow_net_connect = %r[^https?://(localhost|127.0.0.1|maps\.googleapis\.com/maps/api/geocode)] 
  FakeWeb.register_uri(:any, %r|http://blah\.com/blah|, :body => "external web request test")
end

After('@without_geocode', '@javascript') do
  FakeWeb.clean_registry
end