From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 10/12] fbdev: Static pseudocolor with
 depth less than 4 does exist
Date: Sat, 29 Apr 2006 20:28:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0604292025410.4557@pademelon.sonytel.be>
References: <4452B628.1020001@gmail.com> <Pine.LNX.4.62.0604290935310.4557@pademelon.sonytel.be>
 <44535D47.5060000@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZuBb-0000In-On
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 11:28:55 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZuBZ-0002eo-8L
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 11:28:55 -0700
In-Reply-To: <44535D47.5060000@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linux/m68k <linux-m68k@vger.kernel.org>


[ linux-mac68k@mac.linux-m68k.org removed as it seems to bounce? ]

On Sat, 29 Apr 2006, Antonino A. Daplas wrote:
> Geert Uytterhoeven wrote:
> > On Sat, 29 Apr 2006, Antonino A. Daplas wrote:
> >> A static pseudocolor visual with depth less than 4 does exist, so let's
> >> not accidentally upscale the depth with this configuration
> > 
> > Yes it does, at least on Mac/m68k.
> > 
> > Now the real question is: why doesn't macfb set FB_VISUAL_STATIC_PSEUDOCOLOR if
> > there's no macfb_setpalette routine?
> 
> It should.  The other question is, what to do with static pseudocolor?
> Do we always assume console colors?  Or do we make drivers fill their own
> info->cmap entries and not alter the contents when fb_set_cmap() is called?

I don't think you can always assume console colors. Only the driver (if anyone
knows at all) knows the palette.

On the other hand, at least on Mac/m68k the palette is inherited from MacOS.
It would be possible for the Penguin booter to programs the standard console
palette under MacOS, just before booting the kernel, but as I don't know much
about Penguin, I have no idea whether that's currently done.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
