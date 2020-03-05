#!/usr/bin/lua5.3
socket = require 'socket'
socket.unix = require 'socket.unix'

s = assert(socket.unix())
m = arg[1] or 'next\n'

assert(s:connect(os.getenv("SESSION_DIR").."/alt-tab-daemon"))
assert(s:send(m))
