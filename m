From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: set_par/check-var vs. fbcon
Date: Thu, 30 Oct 2003 12:16:45 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1067476604.27090.37.camel@gaston>
References: <Pine.LNX.4.44.0310292220340.21040-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AF1RI-0006gi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 17:17:28 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AF1RH-0006K2-B8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 17:17:27 -0800
In-Reply-To: <Pine.LNX.4.44.0310292220340.21040-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


>    We have the ability to create a var based on height, width and another 
> variable. When we lack EDID data we use the GTF formulas. The function for
> this is fb_get_mode in fbmon.c. Now when we do have EDID info we use the function. 
> For this we have fb_get_monitor_limits. 
>    The monitor info is very important. It is used to validate or invalidate a mode.  
> The next set of functions that are important are:
> 
> fb_validate_mode		-> Used in all cases. Validates a var.
> fb_create_modedb
> fb_destroy_modedb

Well, I know we have those functions, but that doesn't help me
about how we shall use them. Specifically in radeonfb where I
do have the modedb based on EDID at hand (provided I could probe
it, if not, I want to default to the std VESA modes, not some
GTF formula).

The point I'm trying to make is that we are on one side called with
only width/height valid basically (by fbcon) or with a full mode with
timings (from userland ioctl). How do we choose what to do ? Also
userland may want to use our ability to "calculate" a mode based
only on H/W, or may want us to pick one with H/W and a freq, or may
provide us with a full mode with all timings in there. There is
currently no way to make a difference from within the driver on what
data in the passed in "var" are actually to be used to make the
actual mode.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
