From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: clipping
Date: Tue, 7 Jan 2003 22:08:59 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301072207170.21057-100000@vervain.sonytel.be>
References: <1041589565.1014.10.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W0yf-0004ka-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 13:09:37 -0800
In-Reply-To: <1041589565.1014.10.camel@localhost.localdomain>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 3 Jan 2003, Antonino Daplas wrote:
> On Mon, 2002-12-30 at 05:21, Geert Uytterhoeven wrote:
> > cfb_imageblit() takes care of clipping, but forgets to update fb_image.data if
> > fb_image.d[xy] was changed.
> > 
> > BTW, do we really need clipping in fb_ops.fb_{fillrect,copyarea,imageblit}()?
> Personally, I don't think we need clipping.  I tried removing it before
> (circa linux-2.5.30+), but the console segfaults whenever I decrease
> var->yres_virtual.  I haven't tried this again with the newest
> framebuffer framework though.

Any definitive answer on this?

What happens if you resize the VT to such a large size that columns*fontwidth >
xres_virtual or rows*fontheight > yres_virtual? I guess clipping prevents a
crash there?

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
