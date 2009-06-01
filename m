From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add mutex to fbdev for fb_mmap
	locking
Date: Mon, 1 Jun 2009 22:45:51 +0200
Message-ID: <20090601204551.GA2702@elte.hu>
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
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mingo@elte.hu>) id 1MBEOj-0001eO-1S
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 20:46:21 +0000
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MBEOg-0000Q9-MD
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 20:46:21 +0000
Content-Disposition: inline
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
Cc: krzysztof.h1@wp.pl, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, geert@linux-m68k.org, akpm@linux-foundation.org, righi.andrea@gmail.com


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 1 Jun 2009, Krzysztof Helt wrote:
> > 
> > I will fix it.
> 
> Thanks.
> 
> > If the revert to BKL is rejected this patch may wait till 
> > 2.6.31.
> 
> Ahh, so this one helps clean up locking, but doesn't fix any 
> actual regressions? I was going to ask you about that.
> 
> Btw - one thing you could try on the whole lockdep front - and I 
> realize that this is a _total_ hack - is to try the patch below.

One thing that might be less obscure is to add:

	lockdep_off();
	...
	lockdep_on();

to around those user-copies.

Those cause lockdep to totally ignore those dependencies. It's an 
ugly hack - but at least a readable hack IMO. With big red warning 
signs, a promise to fix this ASAP, etc.

It's still much better than a big ugly revert back to the BKL (of 
course - and regardless of how late we are in the cycle) - and 
probably a bit better than the atomic-copy hack.

Or am i missing something?

	Ingo

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
