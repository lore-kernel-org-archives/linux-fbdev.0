From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: set_par/check-var vs. fbcon
Date: Thu, 30 Oct 2003 10:16:24 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310301014290.15545-100000@waterleaf.sonytel.be>
References: <1067476604.27090.37.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AF8uu-0002i6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 01:16:32 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AF8uu-0005Br-1y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 01:16:32 -0800
In-Reply-To: <1067476604.27090.37.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 30 Oct 2003, Benjamin Herrenschmidt wrote:
> >    We have the ability to create a var based on height, width and another 
> > variable. When we lack EDID data we use the GTF formulas. The function for
> > this is fb_get_mode in fbmon.c. Now when we do have EDID info we use the function. 
> > For this we have fb_get_monitor_limits. 
> >    The monitor info is very important. It is used to validate or invalidate a mode.  
> > The next set of functions that are important are:
> > 
> > fb_validate_mode		-> Used in all cases. Validates a var.
> > fb_create_modedb
> > fb_destroy_modedb
> 
> Well, I know we have those functions, but that doesn't help me
> about how we shall use them. Specifically in radeonfb where I
> do have the modedb based on EDID at hand (provided I could probe
> it, if not, I want to default to the std VESA modes, not some
> GTF formula).
> 
> The point I'm trying to make is that we are on one side called with
> only width/height valid basically (by fbcon) or with a full mode with
> timings (from userland ioctl). How do we choose what to do ? Also
> userland may want to use our ability to "calculate" a mode based
> only on H/W, or may want us to pick one with H/W and a freq, or may
> provide us with a full mode with all timings in there. There is
> currently no way to make a difference from within the driver on what
> data in the passed in "var" are actually to be used to make the
> actual mode.

If (when) we convert fbdev to use sysfs instead of ioctls, we can have a magic
file in which you `cat' your var, and another one for `simple' mode specifiers
(cfr. the modedb parameter <width>x<height>[-depth][@refresh]).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
