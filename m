From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] add mutex to fbdev for fb_mmap
	locking
Date: Mon, 1 Jun 2009 22:24:13 +0200
Message-ID: <20090601222413.c2b57c9f.krzysztof.h1@poczta.fm>
References: <200905282134.n4SLYNwv027999@imap1.linux-foundation.org>
	<alpine.LFD.2.01.0905290820510.3435@localhost.localdomain>
	<20090530121128.5f04179d.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905300805350.3435@localhost.localdomain>
	<20090531162453.dff458cb.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905311006070.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MBE4V-0000WV-My
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 20:25:27 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MBE4G-0005Bp-65 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 20:25:19 +0000
In-Reply-To: <alpine.LFD.2.01.0905311006070.3435@localhost.localdomain>
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

On Sun, 31 May 2009 10:09:01 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Sun, 31 May 2009, Krzysztof Helt wrote:
> >  
> >  static int atafb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
> > +__acquires(&info->mm_lock)
> > +__releases(&info->mm_lock)
> 
> Btw, you shouldn't do this when things nest "correctly" - sparse will see 
> the fact that the function acquires and releases a lock and is perfectly 
> happy.
> 

I will fix it. 
If the revert to BKL is rejected this patch may wait till 2.6.31.

Regards,
Krzysztof

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
