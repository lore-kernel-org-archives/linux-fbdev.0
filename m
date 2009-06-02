From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] add mutex to fbdev for fb_mmap
	locking
Date: Tue, 2 Jun 2009 12:51:59 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906021250470.3351@localhost.localdomain>
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
	<20090602203622.244b1a74@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <torvalds@linux-foundation.org>) id 1MBa2j-0007cK-S9
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 19:53:05 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MBa2g-00033a-W7
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 19:53:05 +0000
In-Reply-To: <20090602203622.244b1a74@lxorguk.ukuu.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: krzysztof.h1@wp.pl, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, geert@linux-m68k.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, righi.andrea@gmail.com



On Tue, 2 Jun 2009, Alan Cox wrote:
> 
> I'll fix those over the next few days to copy first, its pretty trivial
> stuff

Btw, it's probably best to put them in functions of their own, and make 
sure they are marked "noinline". Because otherwise gcc will easily inline 
them and because they then presumably have these "struct termios" etc as 
local variables, if that happens gcc will blow your stack to kingdom come.

			Linus

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
