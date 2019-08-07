#!/usr/bin/env python3
# This script will remove the fingerprint portion of the 
# output in regular nmap scans
import sys, os

if len(sys.argv) < 2:
    print("Usage: ./strip_fingerprint.py *filename*")
    os.exit()

filename = sys.argv[1]
with open(filename, "r") as r:
    with open(filename+".clean", "w") as w:
        for line in r:
            if "SERVICE FINGERPRINT" in line:
                None
            elif "SF" in line:
                None
            elif "unrecognized despite" in line:
                None
            else:
                w.write(line)
