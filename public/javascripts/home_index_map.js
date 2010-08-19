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
    $('.current_bounds .width').html(Riat.precision(Riat.olBounds().getWidth()));
    $('.current_bounds .height').html(Riat.precision(Riat.olBounds().getHeight()));
    Riat.bounding_box = bounds.toArray();
}

merc_proj = new OpenLayers.Projection("EPSG:900913");
wgs84_proj = new OpenLayers.Projection("EPSG:4326");

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

// // create Virtual Earth layer
// var veaer = new OpenLayers.Layer.VirtualEarth("Virtual Earth", 
//   {type: VEMapStyle.Aerial, sphericalMercator: true});
    
// create Yahoo layer (only the default layer works, the hybrid and the
// satellite ones do throw exceptions and rendering goes totally bye bye)
// var yahoosat = new OpenLayers.Layer.Yahoo("Yahoo Maps",
//              {sphericalMercator: true}
//              );
  
// Openlayers background
var ol_wms = new OpenLayers.Layer.WMS("OpenLayers WMS",
  "http://labs.metacarta.com/wms/vmap0",
  {layers: "basic"});

// Indonesian province boundaries as WMS
// var IDN0 = new OpenLayers.Layer.WMS("IDN 0","http://www.aifdr.org:8080/geoserver/wms?service=wms",
//   {
//     layers: "test:gadm_IDN_0",
//     transparent: "true",
//     format: "image/png"
//   },
//   {isBaseLayer: false, visibility: false, opacity: 0.7}
// );

// var IDN1 = new OpenLayers.Layer.WMS("IDN 1", "http://www.aifdr.org:8080/geoserver/wms?service=wms",
//   {
//     layers: "test:gadm_IDN_1",
//     transparent: "true",
//     format: "image/png"
//   },
//   {isBaseLayer: false, visibility: true, opacity: 0.6}
// );


var earthquake_intensity_1hz10pc50 = new OpenLayers.Layer.WMS("earthquake_intensity_1hz10pc5",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "hazard:earthquake_intensity_1hz10pc50",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var shakemap_padang_20090930 = new OpenLayers.Layer.WMS("shakemap_padang_20090930",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "hazard:shakemap_padang_20090930",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var lembang_scenario_intensity = new OpenLayers.Layer.WMS("lembang_scenario_intensity",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "hazard:lembang_scenario_intensity",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var population_2010 = new OpenLayers.Layer.WMS("population_2010",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "exposure:population_2010",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


// Map extent for Indonesia in Spherical Mercator coordinates
var initial_boundary = new OpenLayers.Bounds(9062374, -1374643, 15891564, 1130045);

// Add the created layers to the map
map.addLayers([gphy, gsat, ghyb, gmap, ol_wms, 
    earthquake_intensity_1hz10pc50, 
    shakemap_padang_20090930, 
    lembang_scenario_intensity, 
    population_2010]);

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

}

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
       console.log(bounds);
     },
          
     displayClass: 'olControlBox'
     
  });

  map.addControl(boxControl);
}
