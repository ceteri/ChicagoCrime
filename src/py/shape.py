#!/usr/bin/env python
# encoding: utf-8

from lxml import etree
from StringIO import StringIO
from shapely.geometry.polygon import LinearRing
import sys

ns = {
    'kml': 'http://www.opengis.net/kml/2.2'
    }

if __name__ == "__main__":
    ca_file = sys.argv[1]
    ca_poly = {}

    try:
        tree = etree.parse(ca_file)
        root = tree.getroot()

        for place in root.xpath("//kml:Placemark", namespaces=ns):
            xml = etree.XML(etree.tostring(place))

            ca_id = xml.xpath("//kml:SimpleData[@name='DISTNAME']/text()", namespaces=ns)[0]
            coord = xml.xpath("//kml:coordinates/text()", namespaces=ns)[0]

            pts = [map(lambda p: float(p), x.split(",")) for x in coord.split(" ")]
            ring = LinearRing(pts)

            ca_poly[ca_id] = ring
            print "community area:", ca_id, ring

    except:
        sys.stderr.write("%(err)s\n%(data)s\n" % {"err": str(sys.exc_info()[0]), "data": ca_file})
        raise
