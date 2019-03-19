#!/usr/bin/python
import sys

if len(sys.argv) == 1:
    print "Please supply a passwd file name to clean"
    exit()

with open(sys.argv[1], 'r') as file:
    print '\n'.join([line[:line.find(":")] for line in file])
