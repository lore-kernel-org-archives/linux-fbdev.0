From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: fbdev cursor part 1.
Date: Mon, 23 Feb 2004 11:35:51 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077496550.5960.9.camel@gaston>
References: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Av4Iq-0001Np-58
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 16:50:32 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Av40h-0003Pr-2h
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 16:31:47 -0800
In-Reply-To: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

> ment ;-)
> 
> I plan to submit the latets mach64 driver from BK to linus as soon as the 
> first part of the cursor patch goes in. It gives enough of the new 
> cursor api to do a dump of all the drivers in the 2.5 fbdev tree. Could you
> make your patch against the fbdev-2.5 bk tree? Try my patch 
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> If it doesn't work I will put a new one you there.

Note that I'm having some troubles with James current mach64 bk on a
wallstreet PowerBook (mach64 LT-G). There is an endian bug in the
imageblt implementation, I don't know if the chip can be instructed
to do the endian flip, so I modified the function storing to the
fifo, that appear to work, at least with 8 bits mode ;)

But I'm having lockups, very regular. I haven't been able to figure
out why though. Adding a wait_for_idle() at the end of both fillrect
and copyarea() seem to make them disappear (well, almost, I had _one_
still once). It's weird as those shouldn't be necessary.

Maybe we should add a timeout on the wait_* functions with an engine
reset, that would be sub-optimal, but at least we wouldn't lockup the
box (if that is possible of course).

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
