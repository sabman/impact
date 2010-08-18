jQuery(function () {
});

var Riat = {
  bounding_box  : [0, 0, 0, 0],
  hazard        : null,
  exposure      : null
}

Riat.precision = function(original, precision) {
  if(precision === undefined){precision = 4;}
  pow = Math.pow(10, precision);
  return Math.round(original*pow)/pow;
}

Riat.olBounds = (function() {
  return new OpenLayers.Bounds(
    this.bounding_box[0],
    this.bounding_box[1],
    this.bounding_box[2],
    this.bounding_box[3]);
}); 
