From: Antonino Daplas <adaplas@pol.net>
Subject: Re: vm86 patch updated to 2.5.67 / oops in blank_screen()?
Date: Sun, 13 Apr 2003 04:14:08 -0400 (EDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200304130814.h3D8E8H00330@web3.po.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from tom.po.com ([65.112.157.17])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 194ccx-0002s3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Apr 2003 01:14:15 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jurriaan <thunder7@xs4all.nl>, linux-fbdev-devel@lists.sourceforge.net

I believe I've seen that "oops" tracing before.  It is due to console 
blanking routines calling a lot of functions (fb_blank, fb_setcolreg, 
etc), all of which are done when "sleeping" is not allowed.  
However, /dev/vm86 will always sleep, and this causes the oops.

Calling fb_blank via an ioctl is pretty safe though (ie, when xfree86 
uses fb_blank ioctls for XFree86 DPMS).

I worked around this by doing deferred execution of fb_blank (also 
using a workqueue), and differentiating if fb_blank() was called from 
fbcon_blank() or from fb_ioctl().  I think I've also included these 
fixes in vm86d-0.1.tar.gz (md5sum 10fa0ad4647ea6a8a002998196ce6cd9)

Anyway, as a quick workaround, you can make vbe_blank() in vbe.c 
return 0 always.  This will not blank the screen, but it will at 
least prevent the oops.

Tony 


------------------ Reply Separator --------------------
Originally From: Jurriaan <thunder7@xs4all.nl>
Subject: [Linux-fbdev-devel] vm86 patch updated to 2.5.67 / oops in 
blank_screen()?
Date: 04/12/2003 02:55pm


I've been playing with Antonino Daplas' vm86 patch.

First of all, the /dev/vm86 device should read:

crw-------    1 root     root      10, 201 Apr 10 07:07 /dev/vm86

Then, I split the patch in a vm86 and a edid-vbe patch, and dropped 
all
refereces to the non-vesa framebuffers. There were a number of other
changes in the patch which made it difficult to port since it affected
all other framebuffers.

The resulting patches worked quite well, I'm testing here on a single
CPU system with linux-2.5.67 and a Matrox G450 video-card. Once I'm
satisfied it works, I hope to get my Elsa GeForce 3 Ti500 working with
vesa framebuffer and nvidia proprietary drivers.

But, while I was away for some lunch, the computer decided to spoil 
the
general good feeling; it oopsed.

The backtrace was like this:

sys_sched_yield
vm86_exec
vbe_writedac
vbe_setcolreg
fb_set_cmap
fb_blank
timer_do_blank
blank_screen

Could anyone look at the patch (I've appended my version below) and 
tell
me what's going on? I'm no expert in locking in linux. I've tried 
adding
a disable_preempt() calls in vm86_exec(), but that got me lots of
'scheduling while atomic' backtraces.

I suspect this routine isn't quite good:

/**
 * vm86_exec - execute instructions
 * @request: pointer to instruction request data
 * @buffer: 1024-byte min sized buffer for extra data
 *
 * ON ENTRY: @buffer must point to a valid buffer (1024 bytes).
 * ON EXIT: @request contains results of x86 instructions.  @request-
>buffer
 *          may contain additional data, depending on the code.  Check
 *          @request->buf_len.
 * WARNING:
 * Will sleep
 */
int vm86_exec(struct vm86_request *request, void *buffer)
{
        int len;

        if (!info || !info->enabled)
                return -ENODEV;

        if (request->flags & VM86_TEST)
                return 0;

        len = sizeof(struct vm86_request) + request->buf_len;
        if (len > 1024)
                return -EINVAL;

        down(&vm86_sem);

        info->request = *request;
        info->buffer = buffer;
        info->error = 0;
        info->event = 1;
        info->poll_mask = POLLIN | POLLRDNORM;
        kill_fasync(&info->async_queue, SIGIO, POLL_IN);  /* send 
signal */

        wake_up(&vm86_wait);
        while (info->event)
                yield();

        info->request.flags = (info->error) ?
                VM86_FAILED : VM86_SUCCESS;
        *request = info->request;

        up(&vm86_sem);

        return 0;
}

The call to yield() seems not to happen to often in the kernel, but I
don't know how to change this.

The patch below is against linux-2.5.67 (vanilla). There's some 
residual
printk's in there, btw.

I appreciate your help!

Thanks,
Jurriaan
-- 
Debian (Unstable) GNU/Linux 2.5.67-ac1 1970 bogomips load av: 0.04 
0.32 0.33




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
