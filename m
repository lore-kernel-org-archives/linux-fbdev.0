From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: fix fb_info->lock and mm->mmap_sem problem again
Date: Sun, 3 May 2009 21:19:38 +0200
Message-ID: <20090503211938.c9293813.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M0hbw-0003vz-GZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 May 2009 19:44:28 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M0hbs-0008Ak-Cn for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 May 2009 19:44:28 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

Hi,

I have run into the lockdep problem between the fb_info->lock and mm->mmap_sem again.
I run the Mplayer with fbdev output device. The latest git tree.

I looked through the fb_info->lock usage and I have some questions.

The main issue is that fb_mmap acquires the fb_info->lock. I wonder
what is protected there. The part of the fb_mmap which uses the lock
is below:

...
    if (fb->fb_mmap) {
        int res;
        mutex_lock(&info->lock);
        res = fb->fb_mmap(info, vma);
        mutex_unlock(&info->lock);
        return res;
    }

    mutex_lock(&info->lock);

    /* frame buffer memory */
    start = info->fix.smem_start;
    len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.smem_len);
    if (off >= len) {
        /* memory mapped io */
        off -= len;
        if (info->var.accel_flags) {
            mutex_unlock(&info->lock);
            return -EINVAL;
        }
        start = info->fix.mmio_start;
        len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
    }
    mutex_unlock(&info->lock);
...

The lock protects two things:
1. Read of the info->fix.smem_start and info->fix.smem_len.
2. The fbops->fb_mmap call.

The first point seems redundant as I have checked and
the smem_start and smem_len are only set in the
probe and release functions. They are always set
before the register_framebuffer() is called and
after the unregister_framebuffer() call.

If the lock is pushed down into the second point it
becomes the same issue as the first point.

I tracked the usage of the fb_info->lock in the fb
layer and it is used for various purposes:

1. It is used in the fb_open and fb_release functions
as an open() and close() synchronization .

2. It is used in various functions to guard an entry to
the fb_notifier_call_chain() (suspend, blank, register_framebuffer,
unregister_framebuffer).

3. It is used in the fb_ioctl to protect against concurrent
calls to the fb layer.

I understand the third purpose. I am not sure if the
first and the third purpose need to use the same mutex
(ie. if the ioctl and open/close needs to be protected 
against each other - maybe a higher layer does it anyway).

The second purpose (protection of the fb_notifier_call_chain)
is quite a mistery to me. The fb_notifier_call_chain() is just
the blocking_notifier_call_chain() which is already synchronized
with a rw semaphore.

A pure mystery to me is what the fb_info->lock does in the fb_mmap.
What is there trying to be protected?

IMHO, there should be no fb_info->lock usage in the fb_mmap.
If someone needs this lock in driver's fb_mmap (fbops->fb_mmap)
he should lock it by himself possibly releasing the mmap_sem
before and acquiring it after.

Another solution is to divide the fb_info->lock into two
or more smaller mutexes (e.g. mmap_lock so an notifier
or color map change does not block the fb_mmap function).

I want to know what should be protected inside the fb layer.
E.g. changing fb_info->var and reading/using its values should
be synchronized. I am going to prepare few patches to fix
issues I found during code inspection (fb_info->lock
not initialized early enough, some driver's fb_mmap()
functions are just copies of the common fb_mmap, possible
races, etc).

Please forgive me if the above questions are plain stupid.
Krzysztof

----------------------------------------------------------------------
Gotowka na koncie. Otworz konto direct i wez podwojny limit. 	 
http://link.interia.pl/f2145


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
