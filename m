From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Locking problem: fb_info->lock and mm->mmap_sem
Date: Sun, 10 May 2009 20:34:55 +0200
Message-ID: <20090510203455.2ff347e9.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M3Dmx-0003CQ-05
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 May 2009 18:30:15 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M3Dms-00058T-Vp for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 May 2009 18:30:14 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrea Righi <righi.andrea@gmail.com>

Hi again,

I have spent last few days trying to solve the problem with circular locking
between  fb_info->lock and mm->mmap_sem. Finally, I have prepared a patch 
which added a new mutex (fb_info->mm_lock) used to protect changes of 
fb_info->smem_* fields and their usage in the fb_mmap(). It solved existing 
problem with circular locking in the fb_mmap().

However, it unveiled a new problem in the fb_release(). I reverted two patches
which should be not needed if the fb_mmap() problem was fixed:

513adb58685615b0b1d47a3f0d40f5352beff189
fbdev: fix info->lock deadlock in fbcon_event_notify()

66c1ca019078220dc1bf968f2bb18421100ef147
fbmem: fix fb_info->lock and mm->mmap_sem circular locking dependency

and I got another circular locking dependency detected. 

A full dependency log is at the end of the message. Short summary of the lock dep is:

1. sys_munmap() obtains [mm->mmap_sem] and calls indirectly
  :: fb_release() obtains [fb_info->lock]

2. fb_ioctl() obtains [fb_info->lock] and calls indirectly
  :: fb_notifier_call_chain() obtains [fb_notifier_list->rwsem]

3. driver_probe_device() calls indirectly
  :: register_framebuffer() calls indirectly
    :: fb_notifier_call_chain() obtains [fb_notifier_list->rwsem] and calls indirectly
      :: sysfs_create_dir() obtains [sysfs_mutex]

4. sysfs_readdir() obtains [sysfs_mutex] and calls indirectly
  :: copy_to_user() obtains [mm->mmap_sem]

It shows how complicated the issue is. It is not solvable currently,
because one should rethink how locking should work in the fbdev layer.
One single lock is not enough - some functions (fb_mmap, fb_release)
are called with the mm->mmap_sem held. Some functions sends
notifications and the notified objects may obtain the mm->mmap_sem
(e.g. by copy_to_user()).

The problem was introduced by my commit:

3e680aae4e53ab54cdbb0c29257dae0cbb158e1c
fb: convert lock/unlock_kernel() into local fb mutex

becuase I dully converted all lock_kernel() calls into a local 
fb_info->lock but there should be more than one 
mutex/semaphore/spinlock/whatever. I think we should 
return to a version with the BKL and start again from it.

I propose to revert this commit and subsequent commits:

120a37470c2831fea49fdebaceb5a7039f700ce6
framebuffer compat_ioctl deadlock

1f5e31d7e55ac7fbd4ec5e5b20c8868b0e4564c9
 fbmem: don't call copy_from/to_user() with mutex held

66c1ca019078220dc1bf968f2bb18421100ef147
fbmem: fix fb_info->lock and mm->mmap_sem circular locking dependency

6a7f2829b5f8be124e168265f176dbbbea8861a0
fbdev: uninline lock_fb_info()

513adb58685615b0b1d47a3f0d40f5352beff189
fbdev: fix info->lock deadlock in fbcon_event_notify()

I can prepare the patch which contains changes
equivalent to revert of these fixes.

This version does not show any problems. 

Any comment is kindly welcomed.

Regards,
Krzysztof

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.30-rc5 #43
-------------------------------------------------------
mplayer/1117 is trying to acquire lock:
 (&fb_info->lock){+.+...}, at: [<c032c6bf>] fb_release+0x1f/0x60

but task is already holding lock:
 (&mm->mmap_sem){++++++}, at: [<c026e002>] sys_munmap+0x22/0x50

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&mm->mmap_sem){++++++}:
       [<c0243add>] validate_chain+0xa8d/0xfd0
       [<c02442b8>] __lock_acquire+0x298/0x9e0
       [<c0244a74>] lock_acquire+0x74/0xa0
       [<c026a8f7>] might_fault+0x77/0xa0
       [<c031aa43>] copy_to_user+0x33/0x60
       [<c02890b5>] filldir64+0xb5/0xe0
       [<c02bb019>] sysfs_readdir+0x119/0x220
       [<c028922b>] vfs_readdir+0x7b/0x90
       [<c02892a6>] sys_getdents64+0x66/0xc0
       [<c0202c65>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #2 (&sysfs_mutex){+.+.+.}:
       [<c0243add>] validate_chain+0xa8d/0xfd0
       [<c02442b8>] __lock_acquire+0x298/0x9e0
       [<c0244a74>] lock_acquire+0x74/0xa0
       [<c0458183>] mutex_lock_nested+0x53/0x280
       [<c02bb3bc>] sysfs_addrm_start+0x2c/0xb0
       [<c02bb8d0>] create_dir+0x40/0x90
       [<c02bb94b>] sysfs_create_dir+0x2b/0x50
       [<c0314720>] kobject_add_internal+0xc0/0x1a0
       [<c03148fc>] kobject_add_varg+0x4c/0x50
       [<c0314baf>] kobject_add+0x2f/0x60
       [<c037b3cd>] device_add+0xad/0x4c0
       [<c037b7f2>] device_register+0x12/0x20
       [<c037b897>] device_create_vargs+0x97/0xb0
       [<c037b8db>] device_create+0x2b/0x30
       [<c03562b9>] register_con_driver+0xe9/0x130
       [<c035947b>] take_over_console+0x1b/0x50
       [<c03384f2>] fbcon_takeover+0x62/0xb0
       [<c03390b6>] fbcon_event_notify+0x816/0x8f0
       [<c0237ece>] notifier_call_chain+0x4e/0x90
       [<c02380d4>] __blocking_notifier_call_chain+0x44/0x60
       [<c023810a>] blocking_notifier_call_chain+0x1a/0x20
       [<c032c231>] fb_notifier_call_chain+0x11/0x20
       [<c032e30a>] register_framebuffer+0x15a/0x230
       [<cc9dd66b>] matroxfb_probe+0xc2b/0xe10 [matroxfb_base]
       [<c0327fee>] local_pci_probe+0xe/0x10
       [<c0328c2c>] pci_device_probe+0x5c/0x80
       [<c037d938>] driver_probe_device+0x68/0x140
       [<c037da85>] __driver_attach+0x75/0x80
       [<c037cf33>] bus_for_each_dev+0x43/0x70
       [<c037d7d9>] driver_attach+0x19/0x20
       [<c037d5a7>] bus_add_driver+0x1a7/0x230
       [<c037dcaa>] driver_register+0x5a/0x120
       [<c0328fce>] __pci_register_driver+0x4e/0xb0
       [<cc9e41c2>] 0xcc9e41c2
       [<c020102b>] _stext+0x2b/0x150
       [<c024cd45>] sys_init_module+0x85/0x1c0
       [<c0202c65>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #1 ((fb_notifier_list).rwsem){.+.+.+}:
       [<c0243add>] validate_chain+0xa8d/0xfd0
       [<c02442b8>] __lock_acquire+0x298/0x9e0
       [<c0244a74>] lock_acquire+0x74/0xa0
       [<c0458907>] down_read+0x47/0x60
       [<c02380ba>] __blocking_notifier_call_chain+0x2a/0x60
       [<c023810a>] blocking_notifier_call_chain+0x1a/0x20
       [<c032c231>] fb_notifier_call_chain+0x11/0x20
       [<c032cc7c>] fb_set_var+0x17c/0x310
       [<c032de5b>] fb_ioctl+0x2db/0x4d0
       [<c0288610>] vfs_ioctl+0x20/0x70
       [<c0288a34>] do_vfs_ioctl+0x2c4/0x4c0
       [<c0288c69>] sys_ioctl+0x39/0x60
       [<c0202c65>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #0 (&fb_info->lock){+.+...}:
       [<c02435cb>] validate_chain+0x57b/0xfd0
       [<c02442b8>] __lock_acquire+0x298/0x9e0
       [<c0244a74>] lock_acquire+0x74/0xa0
       [<c0458183>] mutex_lock_nested+0x53/0x280
       [<c032c6bf>] fb_release+0x1f/0x60
       [<c027d916>] __fput+0xc6/0x1c0
       [<c027dc68>] fput+0x18/0x20
       [<c026c4cc>] remove_vma+0x3c/0x60
       [<c026cfa5>] do_munmap+0x1f5/0x260
       [<c026e00f>] sys_munmap+0x2f/0x50
       [<c0202c65>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

other info that might help us debug this:

1 lock held by mplayer/1117:
 #0:  (&mm->mmap_sem){++++++}, at: [<c026e002>] sys_munmap+0x22/0x50

stack backtrace:
Pid: 1117, comm: mplayer Tainted: G        W  2.6.30-rc5 #43
Call Trace:
 [<c0242ee8>] print_circular_bug_tail+0x78/0xc0
 [<c0240d83>] ? print_circular_bug_entry+0x43/0x50
 [<c02435cb>] validate_chain+0x57b/0xfd0
 [<c0243139>] ? validate_chain+0xe9/0xfd0
 [<c02442b8>] __lock_acquire+0x298/0x9e0
 [<c0244a74>] lock_acquire+0x74/0xa0
 [<c032c6bf>] ? fb_release+0x1f/0x60
 [<c0458183>] mutex_lock_nested+0x53/0x280
 [<c032c6bf>] ? fb_release+0x1f/0x60
 [<c032c6bf>] fb_release+0x1f/0x60
 [<c027d916>] __fput+0xc6/0x1c0
 [<c027dc68>] fput+0x18/0x20
 [<c026c4cc>] remove_vma+0x3c/0x60
 [<c026cfa5>] do_munmap+0x1f5/0x260
 [<c026e00f>] sys_munmap+0x2f/0x50
 [<c0202c65>] syscall_call+0x7/0xb

----------------------------------------------------------------------
Kup wlasne mieszkanie za 33 tys. zl.
Sprawdz nasze oferty >>> http://link.interia.pl/f215d


------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
