/*
 * compile it with cc lock-keyring.c -o lock-keyring -Wall $(pkg-config gnome-keyring-1 --cflags --libs)
 *
 * Requires: libgnome-keyring-dev
 *
 * Taken from: https://superuser.com/questions/700826/how-to-lock-a-unlocked-gnome-keyring
 */

#include <stdio.h>
#include <gnome-keyring.h>

int main() {
    GnomeKeyringResult lock_result = gnome_keyring_lock_all_sync();
    if (lock_result == GNOME_KEYRING_RESULT_OK) {
        printf("Successfully locked\n");
        return 0;
    } else {
        printf("Error locking keyring: %d\n", lock_result);
        return 1;
    }
}
