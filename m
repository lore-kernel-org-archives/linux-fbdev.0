From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: scrollmode, accel_flags, fbcon.c ...
Date: Sat, 27 Mar 2004 01:42:48 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1080312167.1390.19.camel@gaston>
References: <Pine.LNX.4.58.0403081323040.32244@rosencrantz.theboonies.us>
	 <Pine.GSO.4.58.0403091111540.26626@waterleaf.sonytel.be>
	 <Pine.LNX.4.58.0403260040100.7037@rosencrantz.theboonies.us>
	 <1080267697.3068.24.camel@gaston>
	 <Pine.GSO.4.58.0403260802590.409@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6sY7-0005gb-FM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Mar 2004 06:43:07 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B6sY5-0005IN-P3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Mar 2004 06:43:05 -0800
In-Reply-To: <Pine.GSO.4.58.0403260802590.409@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Eger <eger-dated-1080865620.ef4dea@theboonies.us>, Jakub Jelinek <jj@ultra.linux.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> 
> These are hints for fbcon to use different types of scrolling. Using special
> hardware features is usually faster than doing dumb copies.

Yes, that all make sense, but there isn't a simple way for the fbdev
to set that now in 2.6 since it's in struct display which is now local
to fbcon. fbcon itself will initialize that to some value picked based
on the default var accel flags but I don't like that, espeically since
I think those flags should be deprecated.

> It is (was?) mainly a flag to indicate the fbdev uses and thus owns the accel
> engine. Userspace cannot mmap the MMIO registers and use the accel engine
> unless it first clears this flag. It can also be used just to disable the accel
> engine.

I know, I used them this way in 2.4, but with the 2.6 changes, they
becaome mostly unmanageable.

> These days it seems like vt_cons[vc->vc_num]->vc_mode == KD_TEXT seems to
> indicate the fbdev owns the accel engine, right James?

Yes.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
