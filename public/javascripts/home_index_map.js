var map;
var boxLayer;
var exposure_layers = [];
var hazard_layers = [];
var boxControl;
var merc_proj   = new OpenLayers.Projection("EPSG:900913");
var wgs84_proj  = new OpenLayers.Projection("EPSG:4326");

function init_home_index_map(){

function mapEvent(event) {
    bounds = map.getExtent();
    bounds = bounds.transform(
      map.projection,
      map.displayProjection      
    );      
    $('.current_bounds .bounding_box').html([
      Riat.precision(bounds.left),
      Riat.precision(bounds.bottom),
      Riat.precision(bounds.right), 
      Riat.precision(bounds.top)
    ].join(", "));
    Riat.bounding_box = bounds.toArray();
}


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


//// Exposure layers /////
$.ajax({
  url: '/exposures.json',
  dataType: 'json',
  async: false,
  success: function(data) {
    for (var i=0; i < data.length; i++) {
      map.addLayers([new OpenLayers.Layer.WMS(data[i],
          "http://www.aifdr.org:8080/geoserver/wms?service=wms",
          {layers: "exposure:"+data[i], transparent: "true", format: "image/png", projection: "EPSG:4326"},
          {isBaseLayer: false, visibility: false, opacity: 0.8})]);      
      exposure_layers[i] = data[i];
    }}
});
  

//// Hazard layers /////
$.ajax({
  url: '/hazards.json',
  dataType: 'json',
  async: false,
  success: function(data) {
    for (var i=0; i < data.length; i++) {
      map.addLayers([new OpenLayers.Layer.WMS(data[i],
          "http://www.aifdr.org:8080/geoserver/wms?service=wms",
          {layers: "hazard:"+data[i], transparent: "true", format: "image/png", projection: "EPSG:4326"},
          {isBaseLayer: false, visibility: false, opacity: 0.8})]);      
      hazard_layers[i] = data[i];
    }}
});


//// Rest of the layers /////

var Basemap_600dpi = new OpenLayers.Layer.WMS("Basemap 600dpi",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "backgrounds:Basemap_600dpi",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: true, visibility: false, opacity: 0.8}
                        );

var Basemap_3d = new OpenLayers.Layer.WMS("Basemap 3d",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "backgrounds:Basemap_3d",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: true, visibility: false, opacity: 0.8}
                        );


var Earthquake_Fatalities_Padang_2009 = new OpenLayers.Layer.WMS("Earthquake Fatalities Padang ",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "impact:Earthquake_Fatalities_Padang_2009",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var Earthquake_Fatalities_National = new OpenLayers.Layer.WMS("Earthquake Fatalities Nationa",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "impact:Earthquake_Fatalities_National",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var Earthquake_Fatalities_Lembang = new OpenLayers.Layer.WMS("Earthquake Fatalities Lembang",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "impact:Earthquake_Fatalities_Lembang",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var Province_Boundaries = new OpenLayers.Layer.WMS("Province Boundaries",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "boundaries:Province_Boundaries",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var District_Boundaries = new OpenLayers.Layer.WMS("District Boundaries",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "boundaries:District_Boundaries",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var Subdistrict_Boundaries = new OpenLayers.Layer.WMS("Subdistrict Boundaries",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "boundaries:Subdistrict_Boundaries",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var Subduction_Zones = new OpenLayers.Layer.WMS("Subduction Zones",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "sources:Subduction_Zones",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var Earthquake_Faults = new OpenLayers.Layer.WMS("Earthquake Faults",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "sources:Earthquake_Faults",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var Active_Volcanoes = new OpenLayers.Layer.WMS("Active Volcanoes",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "sources:Active_Volcanoes",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var AIBEP_schools = new OpenLayers.Layer.WMS("AIBEP schools",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "exposure:AIBEP_schools",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );


var School_lembang_buildingloss = new OpenLayers.Layer.WMS("School lembang buildingloss",
                        "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                        {
                            layers: "impact:School_lembang_buildingloss",
                            transparent: "true",
                            format: "image/png"
                        },
                        {isBaseLayer: false, visibility: false, opacity: 0.8}
                        );
var osm = new OpenLayers.Layer.OSM();

map.addLayers([
  Basemap_600dpi, 
  Basemap_3d, 
  osm,
  
  Earthquake_Fatalities_Padang_2009, 
  Earthquake_Fatalities_National, 
  Earthquake_Fatalities_Lembang, 

  Province_Boundaries, 
  District_Boundaries, 
  Subdistrict_Boundaries, 

  Subduction_Zones, 
  Earthquake_Faults, 
  Active_Volcanoes, 

  AIBEP_schools, 
  School_lembang_buildingloss
]);

/// End Adding the layers /////                                        


// Map extent for Indonesia in Spherical Mercator coordinates
var initial_boundary = new OpenLayers.Bounds(9062374, -1374643, 15891564, 1130045);

// Enable switching of layers
map.addControl(new OpenLayers.Control.LayerSwitcher({displayClass: 'olControlLayerSwitcher'}));

// Show coordinates (as lat and lon in WGS84) under mouse pointer	  
mp = new OpenLayers.Control.MousePosition({div: $('#projected_coords')[0]});
mp.displayProjection = wgs84_proj; // WGS84
map.addControl(mp);

map.zoomToExtent(initial_boundary);      

} // init_home_map

function init_box_control() {
  boxControl = new OpenLayers.Control();
  OpenLayers.Util.extend(boxControl, {
     draw: function() {
       this.box = new OpenLayers.Handler.RegularPolygon(boxControl, {"done": this.notice}, {sides:4, irregular:true, persist:true});
       this.box.deactivate();
     },
     
     notice: function(geom) {
       bounds = geom.getBounds();
       Riat.bounding_box = bounds.toArray();
       map.zoomToExtent(bounds);
       for (var i=0; i < boxLayer.features.length; i++) {
         boxLayer.destroyFeatures(boxLayer.features[i]);
       };
       var f = bounds.toGeometry();
       boxLayer.addFeatures([f]);
       boxLayer.redraw();
     },
               
     displayClass: 'olControlBox'     
  });
  map.addControl(boxControl);  
}
