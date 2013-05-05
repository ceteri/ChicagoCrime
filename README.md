ChicagoCrime
============

predictive modeling for crime rates in Chicago wards


Convert from "Community Area" to "Ward"
---------------------------------------
Definitions for "community areas" in Chicago can be downloaded as GIS shapefiles.
The shapefile file `data/chicomm.shp` comes from http://www.lib.uchicago.edu/e/collections/maps/chicomm.zip

Some discussion of how to convert from shapefiles to more general purpose polygons is given in
http://www.quora.com/How-can-I-convert-a-shapefile-to-a-lat-long-polygon-array-for-use-in-Google-Maps

Download, build, and install the GDAL and OGR utilities from http://www.gdal.org/ogr2ogr.html

    ./configure ; make; sudo make install

Download, build, and install the GEOS utilities from http://download.osgeo.org/

    ./configure ; make; sudo make install

Install the `lxml` package from http://lxml.de/ and the `shapely` package from https://pypi.python.org/pypi/Shapely
based on instructions in http://osxastrotricks.wordpress.com/2010/07/19/install-python-shapely/

Next, we convert the shapefile to KML, then parse the KML to construct Shapely polygons as "LinearRings", based on
http://toblerity.github.io/shapely/manual.html#linearrings

    ogr2ogr -f "KML" foo.kml data/chicomm.shp
    ./src/py/shape.py foo.kml
