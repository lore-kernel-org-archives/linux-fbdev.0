From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon_pm.c locking problem
Date: Mon, 05 Jul 2004 17:03:34 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1089065013.3014.19.camel@gaston>
References: <40E59B82.7000807@undead.cc>
	 <20040702185241.GA25832@dreamland.darkstar.lan>
	 <1089035092.3014.7.camel@gaston>
	 <20040705164104.GA14968@dreamland.darkstar.lan>
	 <20040705212436.GA25860@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhbZI-0006iN-IC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 15:04:08 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BhbZI-0006on-39
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 15:04:08 -0700
In-Reply-To: <20040705212436.GA25860@havoc.gtf.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: David Eger <eger@havoc.gtf.org>
Cc: Kronos <kronos@people.it>, John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Your patch is much, much prettier than mine (which is in mainline),
> and Linus is hoping for such a prettier solution.
> 
> On the other hand, is there any reason we're taking this
> rinfo->reg_lock?   Would it be possible for the fb driver to be called
> in two separate contexts at the same time?

QUick fix from the original code I took over from, never had time to
rework that part. I still plan to rewrite most of the mode setting
code in there to, among others, deal with dual head & such, but I lack
time and it's a lot of work.

> Also, having this macro be pretty sort of obsccures the fact that, 
> the way the code is now, we're doing
> 
> 	OUTPLL(foo0, bar0);
> 	OUTPLL(foo1, bar1);
> 	OUTPLL(foo2, bar2);
> 
> which translates to taking this lock three times in quick succession.
> Bleah.
> 
> I had half a mind to put a radeon_fifo_wait() call in the
> OUTREG() macro (because there needs to be a 1-1 correspondence 
> between empty fifo slots and OUTREG calls, but then you add a
> chunk of a loop, udelay, and printk to every register write...
> again lots of overhead for a simple register write.... 
> better to sprinkle the code with the write counts and hope they stay
> in line?  Maybe.  That's the route I took, anyways.
> 
> -dte
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
