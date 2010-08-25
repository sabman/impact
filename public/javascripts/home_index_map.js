var map;
var boxLayer;

function init_home_index_map(){

function mapEvent(event) {
    bounds = map.getExtent();
    bounds = bounds.transform(
      map.projection,
      map.displayProjection      
    );
    console.log(bounds.toString());
    console.log(Riat.olBounds().getWidth());
    console.log(Riat.olBounds().getHeight());
    $('.current_bounds .bounding_box').html([
      Riat.precision(bounds.left),
      Riat.precision(bounds.bottom),
      Riat.precision(bounds.right), 
      Riat.precision(bounds.top)
    ].join(", "));
    // $('.current_bounds .width').html(Riat.precision(Riat.olBounds().getWidth()));
    // $('.current_bounds .height').html(Riat.precision(Riat.olBounds().getHeight()));
    Riat.bounding_box = bounds.toArray();
}

var merc_proj = new OpenLayers.Projection("EPSG:900913");
var wgs84_proj = new OpenLayers.Projection("EPSG:4326");

var options = {
    // the "community" epsg code for spherical mercator
    projection: merc_proj,
    displayProjection: wgs84_proj,
    // map horizontal units are meters
    units: "m",
    // this resolution displays the globe in one 256x256 pixel tile
    maxResolution: 78271.51695,
    // these are the bounds of the globe in sperical mercator
    maxExtent: new OpenLayers.Bounds(-20037508, -20037508,20037508, 20037508),    
    eventListeners: {
        "moveend": mapEvent,
        "zoomend": mapEvent
    }
};
  
// construct a map with the above options
map = new OpenLayers.Map("map-container", options);

// create Google Physical layer

var gphy = new OpenLayers.Layer.Google(
    "Google Physical",
    {type: google.maps.MapTypeId.TERRAIN}
);
var gmap = new OpenLayers.Layer.Google(
    "Google Streets", // the default
    {numZoomLevels: 20}
);
var ghyb = new OpenLayers.Layer.Google(
    "Google Hybrid",
    {type: google.maps.MapTypeId.HYBRID, numZoomLevels: 20}
);
var gsat = new OpenLayers.Layer.Google(
    "Google Satellite",
    {type: google.maps.MapTypeId.SATELLITE, numZoomLevels: 22}
);
  
// Openlayers background
var ol_wms = new OpenLayers.Layer.WMS("OpenLayers WMS",
  "http://labs.metacarta.com/wms/vmap0",
  {layers: "basic"});


boxLayer = new OpenLayers.Layer.Vector("Bounding Box", {displayInLayerSwitcher: false, visibility: true});

layers = [gphy, gsat, ghyb, gmap, ol_wms]
// Add the created layers to the map
map.addLayers(layers);

var hazard_layers = []
$.getJSON('/hazards.json', function(data) {
  for (var i=0; i < data.length; i++) {
      map.addLayers([new OpenLayers.Layer.WMS(data[i],
          "http://www.aifdr.org:8080/geoserver/wms?service=wms",
          {layers: "hazard:"+data[i], transparent: "true", format: "image/png", projection: "EPSG:4326"},
          {isBaseLayer: false, visibility: false, opacity: 0.8})]);
  };
});

var exposure_layers = []
$.getJSON('/exposures.json', function(data) {
  for (var i=0; i < data.length; i++) {
    map.addLayers([new OpenLayers.Layer.WMS(data[i],
        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
        {layers: "exposure:"+data[i], transparent: "true", format: "image/png", projection: "EPSG:4326"},
        {isBaseLayer: false, visibility: false, opacity: 0.8})]);      
  };
});


// var earthquake_fatalities_1hz10pc50 = new OpenLayers.Layer.WMS("earthquake_fatalities_1hz10pc",
//                         "http://www.aifdr.org:8080/geoserver/wms?service=wms",
//                         {
//                             layers: "impact:earthquake_fatalities_1hz10pc50",
//                             transparent: "true",
//                             format: "image/png"
//                         },
//                         {isBaseLayer: false, visibility: false, opacity: 0.8}
//                         );
// 
// 
// var district_boundaries = new OpenLayers.Layer.WMS("district_boundaries",
//                         "http://www.aifdr.org:8080/geoserver/wms?service=wms",
//                         {
//                             layers: "boundaries:district_boundaries",
//                             transparent: "true",
//                             format: "image/png"
//                         },
//                         {isBaseLayer: false, visibility: false, opacity: 0.8}
//                         );
// 
// 
// var subdistrict_boundaries = new OpenLayers.Layer.WMS("subdistrict_boundaries",
//                         "http://www.aifdr.org:8080/geoserver/wms?service=wms",
//                         {
//                             layers: "boundaries:subdistrict_boundaries",
//                             transparent: "true",
//                             format: "image/png"
//                         },
//                         {isBaseLayer: false, visibility: false, opacity: 0.8}
//                         );
// 
// 
// var AIBEP_schools = new OpenLayers.Layer.WMS("AIBEP_schools",
//                         "http://www.aifdr.org:8080/geoserver/wms?service=wms",
//                         {
//                             layers: "exposure:AIBEP_schools",
//                             transparent: "true",
//                             format: "image/png"
//                         },
//                         {isBaseLayer: false, visibility: false, opacity: 0.8}
//                         );
// 
// 
// var subduction_faults = new OpenLayers.Layer.WMS("subduction_faults",
//                         "http://www.aifdr.org:8080/geoserver/wms?service=wms",
//                         {
//                             layers: "sources:subduction_faults",
//                             transparent: "true",
//                             format: "image/png"
//                         },
//                         {isBaseLayer: false, visibility: false, opacity: 0.8}
//                         );
// 
// 
// var subduction_zones = new OpenLayers.Layer.WMS("subduction_zones",
//                         "http://www.aifdr.org:8080/geoserver/wms?service=wms",
//                         {
//                             layers: "sources:subduction_zones",
//                             transparent: "true",
//                             format: "image/png"
//                         },
//                         {isBaseLayer: false, visibility: false, opacity: 0.8}
//                         );
// 
// 
// var active_volcanoes = new OpenLayers.Layer.WMS("active_volcanoes",
//                         "http://www.aifdr.org:8080/geoserver/wms?service=wms",
//                         {
//                             layers: "sources:active_volcanoes",
//                             transparent: "true",
//                             format: "image/png"
//                         },
//                         {isBaseLayer: false, visibility: false, opacity: 0.8}
//                         );


// Map extent for Indonesia in Spherical Mercator coordinates
var initial_boundary = new OpenLayers.Bounds(9062374, -1374643, 15891564, 1130045);


// [gphy, gsat, ghyb, gmap, ol_wms, 
//     earthquake_intensity_1hz10pc50, 
//     shakemap_padang_20090930, 
//     lembang_scenario_intensity, 
//     population_2010,
//     earthquake_fatalities_1hz10pc50, 
//     district_boundaries, 
//     subdistrict_boundaries, 
//     AIBEP_schools, 
//     subduction_faults, 
//     subduction_zones, 
//     active_volcanoes,
//     boxLayer]
// Enable switching of layers	  

map.addControl(new OpenLayers.Control.LayerSwitcher({displayClass: 'olControlLayerSwitcher'}));

// Show coordinates (as lat and lon in WGS84) under mouse pointer	  
mp = new OpenLayers.Control.MousePosition({div: $('#projected_coords')[0]});
mp.displayProjection = wgs84_proj; // WGS84
map.addControl(mp);

// mp2 = new OpenLayers.Control.MousePosition({div: $('#projected_coords')[0]});
// mp2.displayProjection = new OpenLayers.Projection("EPSG:900913"); // spherical mercator - incase we wanna see it
// map.addControl(mp2);

// Zoom to initial view of Indonesia	  
map.zoomToExtent(initial_boundary);      

} // init_home_map

var boxControl;
function init_box_control() {
  boxControl = new OpenLayers.Control();
  OpenLayers.Util.extend(boxControl, {
     draw: function() {
       this.box = new OpenLayers.Handler.RegularPolygon(boxControl,
         {"done": this.notice}, {sides:4, irregular:true, persist:true});
       this.box.deactivate();
     },

     notice: function(geom) {
       console.log(geom.CLASS_NAME);
       bounds = geom.getBounds();
       Riat.bounding_box = bounds.toArray();
       console.log(bounds.toArray()); 
       map.zoomToExtent(bounds);
       // boxLayer = map.getLayersByName("Bounding Box")[0];
       for (var i=0; i < boxLayer.features.length; i++) {
        boxLayer.destroyFeatures(boxLayer.features[i]);
       };
       console.log(boxLayer.features.length);
       var f = bounds.toGeometry();
       boxLayer.addFeatures([f]);
       boxLayer.redraw();
       console.log(boxLayer.features.length);
     },
          
     displayClass: 'olControlBox'
     
  });
  map.addControl(boxControl);  
}

