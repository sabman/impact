jQuery(function () {
});

var Riat = {
  bounding_box  : [0, 0, 0, 0],
  hazard        : null,
  exposure      : null,
  impact        : null  
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


// var control = new OpenLayers.Control();
// OpenLayers.Util.extend(control, {
//     draw: function () {
//         // this Handler.Box will intercept the shift-mousedown
//         // before Control.MouseDefault gets to see it
//         this.box = new OpenLayers.Handler.Box( control,
//             {"done": this.notice},
//             {keyMask: OpenLayers.Handler.MOD_SHIFT});
//         this.box.activate();
//     },
// 
//     notice: function (bounds) {
//         console.log(bounds);
//     }
// });
