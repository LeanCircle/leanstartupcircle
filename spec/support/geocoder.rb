GENERIC_GEOCODE_JSON = <<-JSON
{
  "status": "OK",
  "results": [ {
    "types": [ "street_address" ],
    "formatted_address": "45 Main Street, Long Road, Neverland, England",
    "address_components": [ {
      "long_name": "45 Main Street, Long Road",
      "short_name": "45 Main Street, Long Road",
      "types": [ "route" ]
    }, {
      "long_name": "Neverland",
      "short_name": "Neverland",
      "types": [ "city", "political" ]
    }, {
      "long_name": "England",
      "short_name": "UK",
      "types": [ "country", "political" ]
    } ],
    "geometry": {
      "location": {
        "lat": 0.0,
        "lng": 0.0
      }
    }
  } ]
}
JSON

SF_LSC_GEOCODE_JSON = <<-JSON
{
  "status": "OK",
  "results": [ {
    "types": [ "street_address" ],
    "formatted_address": "San Francisco, California, USA",
    "address_components": [ {
      "long_name": "San Francisco, California, USA",
      "short_name": "San Francisco, California, USA",
      "types": [ "route" ]
    }, {
      "long_name": "San Francisco",
      "short_name": "SF",
      "types": [ "locality", "political" ]
    }, {
      "long_name": "California",
      "short_name": "CA",
      "types": [ "administrative_area_level_1", "political" ]
    }, {
      "long_name": "United States of America",
      "short_name": "US",
      "types": [ "country", "political" ]
    } ],
    "geometry": {
      "location": {
        "lat": 37.7599983215332,
        "lng": -122.44000244140625
      }
    }
  } ]
}
JSON

FakeWeb.register_uri(:any, %r|http://maps\.googleapis\.com/maps/api/geocode|, :body => GENERIC_GEOCODE_JSON)