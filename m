From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Adding an fb_sync() operation to fb_ops
Date: Fri, 31 May 2002 22:14:30 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0205312213000.13028-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0205311240100.3190-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.sonytel.be ([193.74.243.200])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DsnS-0005EB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 May 2002 13:14:50 -0700
In-Reply-To: <Pine.LNX.4.44.0205311240100.3190-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Antonino Daplas <adaplas@pol.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 31 May 2002, James Simmons wrote:
> > Secondly (not related to the topic), I was wondering if we can change
> > the color value passed to fillrect and imageblit.  Presently, the
> > palette index is always passed regardless of the visual. Should the
> > color value passed be reflective of the framebuffer format instead?
> > Pass a palette index if pseudocolor, an RGB value for truecolor, etc.
> >
> > Doing the latter will simplify the low-level drawing function and at the
> > same time, it will make the drawing functions more flexible -- ie,
> > possiblity of exporting to userspace.
> 
> We had this discussion sometime ago. We discovered it was just impossible
> to handle all the possible different color formats in the higher levels.
> We ended up with way to many #ifdefs. So it was decided to let the drivers
> handle it instead. Actually if you wanted it to be useable to userland
> then it makes even more sense to use the color map index instead. Think
> about all the if() statements you would need in userland.

Userland can easily set up function pointers, depending on the used format
(for commonly used formats). Even for the generic case it can be done without
too much loss of efficiency using look-up tables, cfr. fbtest.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
