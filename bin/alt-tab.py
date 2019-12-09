#!/usr/bin/env python3

from i3ipc import Con, Connection, Event
from i3ipc.aio import Con as AsyncCon
from i3ipc.aio import Connection as AsyncConnection
from typing import List
from multiprocessing import Process
import asyncio
import socket
import threading


HOST = '127.0.0.1'
PORT = 8888


def get_ids(container: Con) -> List[int]:
    """
    This function takes a connection to an i3/sway socket and returns
    all the window IDs of the currently focused workspace

    Since sway order changes when focus changes, sort the windows
    """

    list: List[int] = []

    for window in container.workspace():
        list.append(window.id)

    return list


def find_in_list(list: List[int], num) -> int:
    """
    Takes a list of integers and an integer it wants to find and
    returns the first occurrence of the value on the index.
    """
    try:
        x = list.index(num)
    except ValueError:
        print(f'Number {num} not found in List {list}')
        pass

    return x


def next_prev(list: List[int], index: int, goto: bool) -> int:
    """
    Take a list of integers, an integer representing the index and
    a boolean that tells us to go backwards if true or forwards if false

    If we go backwards then just return the index - 1, Python3 always
    allow us to go backwards as long as the number we subtract is not
    bigger than the length of the list.

    If we go forward, first check if we are at the index of the last value
    of a list, if we are then we just return the first index of the list,
    otherwise we return the index + 1
    """
    if not goto:
        return list[index - 1]
    else:
        if index == len(list) - 1:
            return list[0]
        else:
            return list[index + 1]


def main():
    """
    Make a connection with sway
    """
    connection = Connection(None, True)
    container = None
    ids = None
    index = None

    def refresh(connection):
        nonlocal container, ids, index
        container = connection.get_tree()
        container = container.find_focused()
        ids = get_ids(container)
        ids.sort()
        index = find_in_list(ids, container.id)
        print(ids)
        print(index)

    refresh(connection)

    async def refresh_async(connection, _):
        nonlocal container, ids, index
        container = await connection.get_tree()
        container = container.find_focused()
        ids = get_ids(container)
        ids.sort()
        index = find_in_list(ids, container.id)
        print(ids)
        print(index)

    async def event_loop():
        print("Starting event loop")
        connection = await AsyncConnection().connect()

        print("Subscribing to Window events")
        await connection.subscribe([Event.WINDOW])
        connection.on(Event.WINDOW_NEW, refresh_async)
        connection.on(Event.WINDOW_CLOSE, refresh_async)

        print("Subscribing to Workspace events")
        await connection.subscribe([Event.WORKSPACE])
        connection.on(Event.WORKSPACE_FOCUS, refresh_async)

        print("Subscribed to main loop")
        await connection.main()

    async def read_socket(reader, writer):
        nonlocal ids, index
        connection = await AsyncConnection().connect()

        data = await reader.read(100)
        message = data.decode()
    
        if not message:
            None
        if len(ids) < 2:
            None
        if message == 'next':
            await connection.command('[con_id=%s] focus' % next_prev(ids,
                                                                     index,
                                                                     True))
        elif message == 'prev':
            await connection.command('[con_id=%s] focus' % next_prev(ids,
                                                                     index,
                                                                     False))

        writer.write(data)
        await writer.drain()

        writer.close()

    loop = asyncio.get_event_loop()

    asyncio.ensure_future(event_loop())
    asyncio.ensure_future(asyncio.start_unix_server(read_socket,
                                                    '/tmp/alt-tab.sock',
                                                    loop=loop))

    loop.run_forever()

    """
    container = connection.get_tree().find_focused()

    ids: List[int] = get_ids(container)
    ids_len = len(ids)

    if ids_len < 2:
        sys.exit()

    ids.sort()

    index = find_in_list(ids, container.id)

    connection.command('[con_id=%s] focus' % next_prev(ids, index, args.prev))
    """


if __name__ == '__main__':
    main()
