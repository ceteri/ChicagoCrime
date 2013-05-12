#!/usr/bin/env python
# encoding: utf-8

import sys

crime_id = ["ARSON"
,"ASSAULT"
,"BATTERY"
,"BURGLARY"
,"CRIM SEXUAL ASSAULT"
,"CRIMINAL DAMAGE"
,"CRIMINAL TRESPASS"
,"DECEPTIVE PRACTICE"
,"GAMBLING"
,"HOMICIDE"
,"INTERFERE WITH PUBLIC OFFICER"
,"INTERFERENCE WITH PUBLIC OFFICER"
,"INTIMIDATION"
,"KIDNAPPING"
,"LIQUOR LAW VIOLATION"
,"MOTOR VEHICLE THEFT"
,"NARCOTICS"
,"NON-CRIMINAL"
,"OBSCENITY"
,"OFFENSE INVOLVING CHILDREN"
,"OFFENSES INVOLVING CHILDREN"
,"OTHER NARCOTIC VIOLATION"
,"OTHER OFFENSE"
,"PROSTITUTION"
,"PUBLIC INDECENCY"
,"PUBLIC PEACE VIOLATION"
,"Primary Type"
,"ROBBERY"
,"SEX OFFENSE"
,"STALKING"
,"THEFT"
,"WEAPONS VIOLATION"]

wards = range(1,78)
hours = range(0,24)
month = range(0,12)
year = range(2001,2013)
weeks = range(1,8)


if __name__ == "__main__":
    out_file = sys.argv[1]
    f = open(out_file,"w")
    f.write("crime_id,community_area,month,hour,week,Year,Count\n")
    for i in crime_id:
        for j in wards:
            for k in hours:
                for l in month:
                    for y in year:
                       for w in weeks:
                           f.write(str(i)+","+str(j)+","+str(l)+","+str(k)+","+str(w)+","+str(y)+",0"+"\n")

    f.close()
