From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: scrollmode, accel_flags, fbcon.c ...
Date: Fri, 26 Mar 2004 01:14:11 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403260040100.7037@rosencrantz.theboonies.us>
References: <Pine.LNX.4.58.0403081323040.32244@rosencrantz.theboonies.us>
	<Pine.GSO.4.58.0403091111540.26626@waterleaf.sonytel.be>
Reply-To: David Eger <eger-dated-1080865620.ef4dea@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6fBg-0006FC-2J
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Mar 2004 16:27:04 -0800
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B6fBe-0000g6-RM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Mar 2004 16:27:02 -0800
In-Reply-To: <Pine.GSO.4.58.0403091111540.26626@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Jelinek <jj@ultra.linux.cz>, linux-fbdev-devel@lists.sourceforge.net


are scrollmode or accel_flags meaningful to anyone here?

Paging through fbcon.c, I've realized why the radeonfb driver is still 
slow -- the accelerated functions are never being called!  

Hardwiring scrollmode to __SCROLL_YMOVE in updatescrollmode() makes my 
console go a lot faster :)

So within fbcon.c why is there a "scrollmode" variable which can be set
to:  __SCROLL_YWRAP, __SCROLL_YPAN, __SCROLL_YREDRAW, or __SCROLL_YMOVE?

Also accel_flags actually useful to anyone?  I see in the fb code some
half-hearted attempts to test for FB_ACCELF_TEXT, but it's not clear at
all to me where these accel flags are supposed to be set... are they even
relevant with the new accel interface?  It seems all this is properly
replaced by filling in the fbops to either the driver's custom fillrect()
or cfb_fillrect(), no?

-dte



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
