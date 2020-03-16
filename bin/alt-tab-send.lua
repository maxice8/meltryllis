#!/usr/bin/lua5.3
local socket = require 'socket'
socket.unix = require 'socket.unix'

local s = assert(socket.unix())
local m = arg[1] or 'next\n'

assert(s:connect(os.getenv("SESSION_DIR").."/alt-tab-daemon"))
assert(s:send(m))
