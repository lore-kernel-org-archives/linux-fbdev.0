From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: clipping
Date: Wed, 8 Jan 2003 10:54:12 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301081053400.21171-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301072211310.17129-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WCx9-0003q5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 01:56:51 -0800
In-Reply-To: <Pine.LNX.4.44.0301072211310.17129-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 7 Jan 2003, James Simmons wrote:
> > > > BTW, do we really need clipping in fb_ops.fb_{fillrect,copyarea,imageblit}()?
> > > Personally, I don't think we need clipping.  I tried removing it before
> > > (circa linux-2.5.30+), but the console segfaults whenever I decrease
> > > var->yres_virtual.  I haven't tried this again with the newest
> > > framebuffer framework though.
> > 
> > Any definitive answer on this?
> > 
> > What happens if you resize the VT to such a large size that columns*fontwidth >
> > xres_virtual or rows*fontheight > yres_virtual? I guess clipping prevents a
> > crash there?
> 
> Correct. Actually fbcon_resize checks to make sure the user doesn't do 
> something stupid like this. So we might not needed. Hm.

And what if you use fbset to reduce the resolution below what's needed to
accomodate the current console size?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
