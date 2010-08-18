class Coverage 
    attr_accessor :version, :identifier, :coverage, :crs_urn, :boundingbox, :bbox, :format, :base_url, :resx, :resy, :url
  # TODO get the metadata about the layer from DescribeCoverage Request:
  # http://www.aifdr.org:8080/geoserver/wcs?version=1.1.1&service=WCS&request=DescribeCoverage&identifiers=mmi_intensity_10pc50_high_res
  def initialize(base_url, layername)
    @version="1.0.0"
    @identifier=layername
    @coverage=@identifier
    @crs_urn="urn:ogc:def:crs:EPSG::4326"
    @boundingbox="-1.0,96.0,4.0,100.0,#{@crs_urn}" 
    @bbox="96.0,-1.0,100.0,4.0"
    @xmin, ymin, xmax, ymax = @bbox.split(',')
    @crs="EPSG:4326" 
    @format="GeoTIFF"   # TODO get the metadata about the layer from DescribeCoverage Request
    @formats=[@format]  # TODO get the metadata about the layer from DescribeCoverage Request
    @base_url=base_url
    @resx="0.08"  # TODO get the metadata about the layer from DescribeCoverage Request
    @resy="-0.08" # TODO get the metadata about the layer from DescribeCoverage Request
    @url="${base_url}?version=${version}&service=${service}&request=${request}&identifier=${identifier}&format=${format}&BoundingBox=${BoundingBox}&store=${store}&coverage=${coverage}&crs=${crs}&bbox=${bbox}&resx=${resx}&resy=${resy}"
  end
end