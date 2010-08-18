jQuery(function () {
});

var Riat = {
  bounding_box  : null,
  hazard        : null,
  exposure      : null
}

Riat.precision = function(original, precision) {
  if(precision === undefined){precision = 4;}
  pow = Math.pow(10, precision);
  return Math.round(original*pow)/pow;
}