From: "Dr. David Alan Gilbert" <linux@treblig.org>
Date: Fri, 01 Apr 2011 19:47:06 +0000
Subject: udlfb.c dlfb_ops_ioctl - missing copy_from_user's ?
Message-Id: <20110401194706.GA28823@gallifrey>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,
 I was running sparse() over the kernel and it noticed
a few casts in dlfb_ops_ioctl that got me looking.

In the DLFB_IOCTL_RETURN_EDID case copy_to_user is used to write to
the data pointed to by arg, but in the DLFB_IOCTL_REPORT_DAMAGE
case the data is accessed directly:

        /* TODO: Help propose a standard fb.h ioctl to report mmap damage */
        if (cmd = DLFB_IOCTL_REPORT_DAMAGE) {

                /*
                 * If we have a damage-aware client, turn fb_defio "off"
                 * To avoid perf imact of unecessary page fault handling.
                 * Done by resetting the delay for this fb_info to a very
                 * long period. Pages will become writable and stay that way.
                 * Reset to normal value when all clients have closed this fb.
                 */
                if (info->fbdefio)
                        info->fbdefio->delay = DL_DEFIO_WRITE_DISABLE;

                area = (struct dloarea *)arg;

                if (area->x < 0)
                        area->x = 0;

It looks to me like making area a local variable and then copy_from_user'ing
it from arg is needed.   I don't think there is anything further up in the
call chain that is doing the copy is there?

(On a more minor note, in dlfb_ops_open the line:

         if ((user = 0) & (!console))

looks like it should really be && - not that I think it makes any
difference.)

Dave (please cc, not subscribed to linux-fbdev)
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
