ChicagoCrime
============

predictive modeling for crime rates in Chicago wards


Convert from "Community Area" to "Ward"
---------------------------------------

`data/chicomm.shp` comes from http://www.lib.uchicago.edu/e/collections/maps/chicomm.zip


http://www.quora.com/How-can-I-convert-a-shapefile-to-a-lat-long-polygon-array-for-use-in-Google-Maps
http://www.gdal.org/ogr2ogr.html

    ./configure ; make; sudo make install
    ogr2ogr -f "KML" foo.kml data/chicomm.shp


http://osxastrotricks.wordpress.com/2010/07/19/install-python-shapely/
https://pypi.python.org/pypi/Shapely

    wget http://download.osgeo.org/geos/geos-3.2.2.tar.bz2
    tar xzvf geos-3.2.2.tar.bz2
    ./configure ; make; sudo make install

    pip install Shapely


http://toblerity.github.io/shapely/manual.html#linearrings
