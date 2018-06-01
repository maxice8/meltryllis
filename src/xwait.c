/* 
 * use it to hold your X session.
 * You can either compile it, or run it through tcc using it's special shebang,
 * that's up to you, really.
 *
 * echo "exec xwait" >> ~/.xinitrc
 *
 */

#include <unistd.h>
#include <sys/wait.h>

int
main ()
    {
    for( ;; )
        {
        wait( NULL );
        sleep( 1 );
        }

    return 0;
    }

/* vim: set ft=c: */
