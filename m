From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add mutex to fbdev for fb_mmap
	locking
Date: Tue, 2 Jun 2009 20:36:22 +0100
Message-ID: <20090602203622.244b1a74@lxorguk.ukuu.org.uk>
References: <200905282134.n4SLYNwv027999@imap1.linux-foundation.org>
	<alpine.LFD.2.01.0905290820510.3435@localhost.localdomain>
	<20090530121128.5f04179d.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905300805350.3435@localhost.localdomain>
	<20090531162453.dff458cb.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905311006070.3435@localhost.localdomain>
	<20090601222413.c2b57c9f.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0906011329400.3435@localhost.localdomain>
	<20090602200626.1c3486e1.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0906021105340.3351@localhost.localdomain>
	<20090602195240.0af2f21c@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.01.0906021154270.3351@localhost.localdomain>
	<alpine.LFD.2.01.0906021200420.3351@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alan@lxorguk.ukuu.org.uk>) id 1MBZm9-0000AW-LM
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 19:35:57 +0000
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]
	helo=www.etchedpixels.co.uk)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MBZm3-0006oh-2T
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 19:35:52 +0000
In-Reply-To: <alpine.LFD.2.01.0906021200420.3351@localhost.localdomain>
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
Cc: krzysztof.h1@wp.pl, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, geert@linux-m68k.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, righi.andrea@gmail.com

> And then there is TIOCGSOFTCAR, which is just insane, and apparently gets 
> the lock in order to just test _one_ bit (C_CLOCAL). Never mind that if 

If you don't take it there are cases where it gets cleared by drivers
momentarily and put back so you would give the wrong answer.

> something is changing it, we really don't care _which_ case we return, so 
> the lock is likely pointless to begin with (can "termios" actually change 
> as a pointer?). But then does the user space access with the lock held.

I'll fix those over the next few days to copy first, its pretty trivial
stuff

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
