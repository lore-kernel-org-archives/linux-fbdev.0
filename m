From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: scrollmode, accel_flags, fbcon.c ...
Date: Fri, 26 Mar 2004 13:21:37 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1080267697.3068.24.camel@gaston>
References: <Pine.LNX.4.58.0403081323040.32244@rosencrantz.theboonies.us>
	 <Pine.GSO.4.58.0403091111540.26626@waterleaf.sonytel.be>
	 <Pine.LNX.4.58.0403260040100.7037@rosencrantz.theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6gyx-0004lm-4k
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Mar 2004 18:22:03 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B6gyw-0008C3-1m
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Mar 2004 18:22:02 -0800
In-Reply-To: <Pine.LNX.4.58.0403260040100.7037@rosencrantz.theboonies.us>
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
To: David Eger <eger-dated-1080865620.ef4dea@theboonies.us>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Jelinek <jj@ultra.linux.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2004-03-26 at 11:14, David Eger wrote:
> are scrollmode or accel_flags meaningful to anyone here?
> 
> Paging through fbcon.c, I've realized why the radeonfb driver is still 
> slow -- the accelerated functions are never being called!  
> 
> Hardwiring scrollmode to __SCROLL_YMOVE in updatescrollmode() makes my 
> console go a lot faster :)

Heh, good catch ;)

> So within fbcon.c why is there a "scrollmode" variable which can be set
> to:  __SCROLL_YWRAP, __SCROLL_YPAN, __SCROLL_YREDRAW, or __SCROLL_YMOVE?

Never been too sure about those. James ?

> Also accel_flags actually useful to anyone?  I see in the fb code some
> half-hearted attempts to test for FB_ACCELF_TEXT, but it's not clear at
> all to me where these accel flags are supposed to be set... are they even
> relevant with the new accel interface?  It seems all this is properly
> replaced by filling in the fbops to either the driver's custom fillrect()
> or cfb_fillrect(), no?

I think they are irrelevant, I removed most of the stuff using that
in radeonfb, it would not work properly. I'm not sure what to do with
the scrollmode though. I'll have to experiment.

Ben.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
