From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH]: Various fbdev fixes:
Date: Fri, 24 Jan 2003 19:38:02 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301241937440.31541-100000@phoenix.infradead.org>
References: <1042688316.970.21.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18c9eu-00075k-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 11:38:37 -0800
In-Reply-To: <1042688316.970.21.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Hi James,
> 
> It seems that the 32/64-bit patch for fast_imageblit() and the
> "non-divisible by 8 width" fix for slow_imageblit() did not completely
> take.  So here's an updated patch against linux-2.5.58 + your latest
> fbdev.diff:
> 
> a.  Fix for fast_imageblit() being unclean on 64-bit and higher
> machines:  With the change, the 32-bit tables will be accessed 2 (or
> more) times  on >= 64-bit machines before doing a single FB_WRITEL. 
> Because the extra tests and bit packing impose a performance penalty for
> 32-bit machines, 32-bit machines undergo a different, faster, and
> simpler path.
> 
> c.  Fix for slow_imageblit() being unclean for bitmaps with widths not
> divisible by 8.
> 
> d.  Fix for fbcon_resize().  Update display.vrows after fb_set_var(). 
> This should fix console problems when fb_var_screeninfo.yres_virtual is
> changed and y-panning is enabled. Only activated when fbcon_switch() is
> called.
> 
> e.  Trivial:  info->fbops->fb_sync() may not be necessary in
> accel_putcs().

Applied.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
