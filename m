From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] add mutex to fbdev for fb_mmap
	locking
Date: Tue, 2 Jun 2009 20:06:26 +0200
Message-ID: <20090602200626.1c3486e1.krzysztof.h1@poczta.fm>
References: <200905282134.n4SLYNwv027999@imap1.linux-foundation.org>
	<alpine.LFD.2.01.0905290820510.3435@localhost.localdomain>
	<20090530121128.5f04179d.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905300805350.3435@localhost.localdomain>
	<20090531162453.dff458cb.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905311006070.3435@localhost.localdomain>
	<20090601222413.c2b57c9f.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0906011329400.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MBYGt-0006i4-MV
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 17:59:35 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MBYGr-0000J7-Tw for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 17:59:35 +0000
In-Reply-To: <alpine.LFD.2.01.0906011329400.3435@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: krzysztof.h1@wp.pl, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, geert@linux-m68k.org, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, righi.andrea@gmail.com

On Mon, 1 Jun 2009 13:38:40 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> Btw - one thing you could try on the whole lockdep front - and I realize 
> that this is a _total_ hack - is to try the patch below.
> 
> The _only_ thing it does is to hide the sysfs_mutex -> mm_lock chain from 
> lockdep, by using the (incorrect) __copy_to_user_inatomic() instead of the 
> (correct) copy_to_user(). But I'd like to hear if that sysfs_mutex in 
> readdir is the only way you can get a chain.
> 

Not only. The patch uncovers another lockdep. My fb_mmap patch was applied
during this test.

I will investigate the fb_notifier_list.rwsem issue and how to solve this 
but not for the 2.6.30 (I don't enough time).

Regards,
Krzysztof

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.30-rc7 #5
-------------------------------------------------------
mplayer/1267 is trying to acquire lock:
 (&fb_info->lock){+.+.+.}, at: [<c032c71f>] fb_release+0x1f/0x60

but task is already holding lock:
 (&mm->mmap_sem){++++++}, at: [<c026e072>] sys_munmap+0x22/0x50

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&mm->mmap_sem){++++++}:
       [<c0243b3d>] validate_chain+0xa8d/0xfd0
       [<c0244318>] __lock_acquire+0x298/0x9e0
       [<c0244ad4>] lock_acquire+0x74/0xa0
       [<c026a967>] might_fault+0x77/0xa0
       [<c031aa93>] copy_to_user+0x33/0x60
       [<c0351a38>] tty_mode_ioctl+0x98/0x4c0
       [<c0351e9a>] n_tty_ioctl_helper+0x3a/0x180
       [<c034ed67>] n_tty_ioctl+0x27/0xd0
       [<c034d96e>] tty_ioctl+0xae/0x850
       [<c0288610>] vfs_ioctl+0x20/0x70
       [<c0288a34>] do_vfs_ioctl+0x2c4/0x4c0
       [<c0288c69>] sys_ioctl+0x39/0x60
       [<c0202c65>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #2 (&tty->termios_mutex){+.+...}:
       [<c0243b3d>] validate_chain+0xa8d/0xfd0
       [<c0244318>] __lock_acquire+0x298/0x9e0
       [<c0244ad4>] lock_acquire+0x74/0xa0
       [<c044d4c3>] mutex_lock_nested+0x53/0x280
       [<c034c5c2>] tty_do_resize+0x22/0xe0
       [<c035f06d>] vc_do_resize+0x2fd/0x380
       [<c035f15b>] vc_resize+0x1b/0x30
       [<c03382eb>] fbcon_init+0x19b/0x400
       [<c035aec0>] visual_init+0x80/0xc0
       [<c035ea28>] bind_con_driver+0x158/0x2e0
       [<c035ebe3>] take_over_console+0x33/0x50
       [<c03385b2>] fbcon_takeover+0x62/0xb0
       [<c0339175>] fbcon_event_notify+0x815/0x8f0
       [<c0237f1e>] notifier_call_chain+0x4e/0x90
       [<c0238124>] __blocking_notifier_call_chain+0x44/0x60
       [<c023815a>] blocking_notifier_call_chain+0x1a/0x20
       [<c032c291>] fb_notifier_call_chain+0x11/0x20
       [<c032e3d7>] register_framebuffer+0x177/0x240
       [<ccacc5a6>] radeonfb_pci_register+0x9d6/0xd70 [radeonfb]
       [<c032804e>] local_pci_probe+0xe/0x10
       [<c0328c8c>] pci_device_probe+0x5c/0x80
       [<c0371548>] driver_probe_device+0x68/0x140
       [<c0371695>] __driver_attach+0x75/0x80
       [<c0370b23>] bus_for_each_dev+0x43/0x70
       [<c03713e9>] driver_attach+0x19/0x20
       [<c03711a3>] bus_add_driver+0x1b3/0x250
       [<c03718ea>] driver_register+0x5a/0x120
       [<c032902e>] __pci_register_driver+0x4e/0xb0
       [<ccad5017>] 0xccad5017
       [<c020102b>] _stext+0x2b/0x150
       [<c024ce05>] sys_init_module+0x85/0x1c0
       [<c0202c65>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #1 ((fb_notifier_list).rwsem){.+.+.+}:
       [<c0243b3d>] validate_chain+0xa8d/0xfd0
       [<c0244318>] __lock_acquire+0x298/0x9e0
       [<c0244ad4>] lock_acquire+0x74/0xa0
       [<c044dc47>] down_read+0x47/0x60
       [<c023810a>] __blocking_notifier_call_chain+0x2a/0x60
       [<c023815a>] blocking_notifier_call_chain+0x1a/0x20
       [<c032c291>] fb_notifier_call_chain+0x11/0x20
       [<c032e3d7>] register_framebuffer+0x177/0x240
       [<ccacc5a6>] radeonfb_pci_register+0x9d6/0xd70 [radeonfb]
       [<c032804e>] local_pci_probe+0xe/0x10
       [<c0328c8c>] pci_device_probe+0x5c/0x80
       [<c0371548>] driver_probe_device+0x68/0x140
       [<c0371695>] __driver_attach+0x75/0x80
       [<c0370b23>] bus_for_each_dev+0x43/0x70
       [<c03713e9>] driver_attach+0x19/0x20
       [<c03711a3>] bus_add_driver+0x1b3/0x250
       [<c03718ea>] driver_register+0x5a/0x120
       [<c032902e>] __pci_register_driver+0x4e/0xb0
       [<ccad5017>] 0xccad5017
       [<c020102b>] _stext+0x2b/0x150
       [<c024ce05>] sys_init_module+0x85/0x1c0
       [<c0202c65>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #0 (&fb_info->lock){+.+.+.}:
       [<c024362b>] validate_chain+0x57b/0xfd0
       [<c0244318>] __lock_acquire+0x298/0x9e0
       [<c0244ad4>] lock_acquire+0x74/0xa0
       [<c044d4c3>] mutex_lock_nested+0x53/0x280
       [<c032c71f>] fb_release+0x1f/0x60
       [<c027d9a6>] __fput+0xc6/0x1c0
       [<c027dcf8>] fput+0x18/0x20
       [<c026c53c>] remove_vma+0x3c/0x60
       [<c026d015>] do_munmap+0x1f5/0x260
       [<c026e07f>] sys_munmap+0x2f/0x50
       [<c0202c65>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

other info that might help us debug this:

1 lock held by mplayer/1267:
 #0:  (&mm->mmap_sem){++++++}, at: [<c026e072>] sys_munmap+0x22/0x50

stack backtrace:
Pid: 1267, comm: mplayer Tainted: G        W  2.6.30-rc7 #5
Call Trace:
 [<c0242f48>] print_circular_bug_tail+0x78/0xc0
 [<c0240de3>] ? print_circular_bug_entry+0x43/0x50
 [<c024362b>] validate_chain+0x57b/0xfd0
 [<c0244318>] __lock_acquire+0x298/0x9e0
 [<c0241e6b>] ? trace_hardirqs_on+0xb/0x10
 [<c0244ad4>] lock_acquire+0x74/0xa0
 [<c032c71f>] ? fb_release+0x1f/0x60
 [<c044d4c3>] mutex_lock_nested+0x53/0x280
 [<c032c71f>] ? fb_release+0x1f/0x60
 [<c026a708>] ? free_pgd_range+0x128/0x170
 [<c032c71f>] fb_release+0x1f/0x60
 [<c027d9a6>] __fput+0xc6/0x1c0
 [<c027dcf8>] fput+0x18/0x20
 [<c026c53c>] remove_vma+0x3c/0x60
 [<c026d015>] do_munmap+0x1f5/0x260
 [<c026e07f>] sys_munmap+0x2f/0x50
 [<c0202c65>] syscall_call+0x7/0xb

----------------------------------------------------------------------
Audi kilka tysiecy zlotych taniej? Przebieraj wsrod tysiecy ogloszen!
Sprawdz >>> http://link.interia.pl/f21b7


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
