GMaps.geolocate=function(a){var b=a.always||a.complete;if(navigator.geolocation){navigator.geolocation.getCurrentPosition(function(c){a.success(c);if(b){b()}},function(c){a.error(c);if(b){b()}},a.options)}else{a.not_supported();if(b){b()}}};GMaps.geocode=function(a){this.geocoder=new google.maps.Geocoder();var b=a.callback;if(a.hasOwnProperty("lat")&&a.hasOwnProperty("lng")){a.latLng=new google.maps.LatLng(a.lat,a.lng)}delete a.lat;delete a.lng;delete a.callback;this.geocoder.geocode(a,function(d,c){b(d,c)})};