From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] add mutex to fbdev for fb_mmap
	locking
Date: Tue, 2 Jun 2009 11:13:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906021105340.3351@localhost.localdomain>
References: <200905282134.n4SLYNwv027999@imap1.linux-foundation.org>
	<alpine.LFD.2.01.0905290820510.3435@localhost.localdomain>
	<20090530121128.5f04179d.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905300805350.3435@localhost.localdomain>
	<20090531162453.dff458cb.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905311006070.3435@localhost.localdomain>
	<20090601222413.c2b57c9f.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0906011329400.3435@localhost.localdomain>
	<20090602200626.1c3486e1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <torvalds@linux-foundation.org>) id 1MBYV7-0000XQ-Gw
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 18:14:17 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MBYV6-0001Ib-9m
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 18:14:17 +0000
In-Reply-To: <20090602200626.1c3486e1.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: krzysztof.h1@wp.pl, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, geert@linux-m68k.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, righi.andrea@gmail.com


Alan cc'd due to the terminal layer locking thing.

On Tue, 2 Jun 2009, Krzysztof Helt wrote:
> 
> Not only. The patch uncovers another lockdep. My fb_mmap patch was applied
> during this test.
> 
> I will investigate the fb_notifier_list.rwsem issue and how to solve this 
> but not for the 2.6.30 (I don't enough time).

Sure.  Thanks for testing. This one still seems to be all about the fb 
registration phase (ie no runtime deadlocks), an I guess a 

        lockdep_off();
        ...
        lockdep_on();

around just the registration part would have been the much better thing to 
do (ie snip the lockdep chains at the actual point we don't care about).

That said, this particular lockdep chain does point to an interesting 
chain in the loop:

> -> #3 (&mm->mmap_sem){++++++}:
>        [<c0243b3d>] validate_chain+0xa8d/0xfd0
>        [<c0244318>] __lock_acquire+0x298/0x9e0
>        [<c0244ad4>] lock_acquire+0x74/0xa0
>        [<c026a967>] might_fault+0x77/0xa0
>        [<c031aa93>] copy_to_user+0x33/0x60
>        [<c0351a38>] tty_mode_ioctl+0x98/0x4c0
>        [<c0351e9a>] n_tty_ioctl_helper+0x3a/0x180
>        [<c034ed67>] n_tty_ioctl+0x27/0xd0
>        [<c034d96e>] tty_ioctl+0xae/0x850
>        [<c0288610>] vfs_ioctl+0x20/0x70
>        [<c0288a34>] do_vfs_ioctl+0x2c4/0x4c0
>        [<c0288c69>] sys_ioctl+0x39/0x60
>        [<c0202c65>] syscall_call+0x7/0xb
>        [<ffffffff>] 0xffffffff

ie the fact that the TTY layer does user-mode copies while holding some 
tty lock. So now the tty layer introduces that chain from some random lock 
to the mmap_sem.

(Which is not a deadlock in itself, but is now a very strong link in a 
chain of locking for any device driver that does both mmap() and acts as a 
tty. Admittedly fbcon is perhaps fairly unique in that).

I thought we had gotten rid of all of those. And we probably did - on the 
read/write side. But apparently not termios_lock.

> -> #2 (&tty->termios_mutex){+.+...}:
>        [<c0243b3d>] validate_chain+0xa8d/0xfd0
>        [<c0244318>] __lock_acquire+0x298/0x9e0
>        [<c0244ad4>] lock_acquire+0x74/0xa0
>        [<c044d4c3>] mutex_lock_nested+0x53/0x280
>        [<c034c5c2>] tty_do_resize+0x22/0xe0
>        [<c035f06d>] vc_do_resize+0x2fd/0x380
>        [<c035f15b>] vc_resize+0x1b/0x30
>        [<c03382eb>] fbcon_init+0x19b/0x400
>        [<c035aec0>] visual_init+0x80/0xc0
>        [<c035ea28>] bind_con_driver+0x158/0x2e0
>        [<c035ebe3>] take_over_console+0x33/0x50
>        [<c03385b2>] fbcon_takeover+0x62/0xb0
>        [<c0339175>] fbcon_event_notify+0x815/0x8f0
>        [<c0237f1e>] notifier_call_chain+0x4e/0x90
>        [<c0238124>] __blocking_notifier_call_chain+0x44/0x60
>        [<c023815a>] blocking_notifier_call_chain+0x1a/0x20
>        [<c032c291>] fb_notifier_call_chain+0x11/0x20
>        [<c032e3d7>] register_framebuffer+0x177/0x240

And here we have the other link in the chain. Again, it's to that fairly 
uninteresting "register_framebuffer()", so in practice none of this will 
ever deadlock, but it shows how easy it is to get subtle chains like that.

			Linus

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
