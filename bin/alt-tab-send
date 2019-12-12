#!/usr/bin/python3

from os import environ, path
from sys import argv
from socket import socket, AF_UNIX

SOCKET = path.join(environ['SESSION_DIR'], 'alt-tab-daemon')


def main(action: bytes):
    sock = socket(AF_UNIX)
    sock.connect(SOCKET)
    sock.send(action)


if __name__ == '__main__':
    if len(argv) > 1:
        action = argv[1]
    else:
        action = 'next'

    main(action.encode())
