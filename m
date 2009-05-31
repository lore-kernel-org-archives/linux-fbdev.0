From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] add mutex to fbdev for fb_mmap
	locking
Date: Sun, 31 May 2009 10:09:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905311006070.3435@localhost.localdomain>
References: <200905282134.n4SLYNwv027999@imap1.linux-foundation.org>
	<alpine.LFD.2.01.0905290820510.3435@localhost.localdomain>
	<20090530121128.5f04179d.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905300805350.3435@localhost.localdomain>
	<20090531162453.dff458cb.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <torvalds@linux-foundation.org>) id 1MAoXN-0007r6-Tq
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 May 2009 17:09:33 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MAoXM-0007Wq-To
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 May 2009 17:09:33 +0000
In-Reply-To: <20090531162453.dff458cb.krzysztof.h1@poczta.fm>
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
Cc: krzysztof.h1@wp.pl, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, geert@linux-m68k.org, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, righi.andrea@gmail.com



On Sun, 31 May 2009, Krzysztof Helt wrote:
>  
>  static int atafb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
> +__acquires(&info->mm_lock)
> +__releases(&info->mm_lock)

Btw, you shouldn't do this when things nest "correctly" - sparse will see 
the fact that the function acquires and releases a lock and is perfectly 
happy.

The extra annotations are helpful only if you have a function that does 
something _unexpected_ to a lock, like first releasing it and then 
re-aqcuiring it, or releasing it without acquiring it at all. Then the 
extra annotations (a) tell sparse not to complain about odd locking, and 
(b) act as visual notification to users that this function drops a lock in 
the middle.

I haven't actually looked at the patch yet, I just reacted to this part of 
it.

		Linus

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
