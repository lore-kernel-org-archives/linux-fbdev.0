From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_imageblit()
Date: Fri, 10 Jan 2003 20:41:04 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301102036520.18440-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301101857310.18287-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18X52l-0001Hh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 11:42:15 -0800
In-Reply-To: <Pine.LNX.4.44.0301101857310.18287-100000@phoenix.infradead.org>
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

On Fri, 10 Jan 2003, James Simmons wrote:
> > Secondly, indexing the cmap instead of the pseudo_palette means that
> > cfb_imageblit has to know the native framebuffer format.  
> 
> No indexing the cmap. Instead call fb_set_cmap before we call 
> xxxfb_imageblit. Personally I think we should call fb_set_cmap always.
> 
> > I would rather have everything refer to
> > the pseudopalette, regardless of the visual format.  This will be better
> > especially for some of the corner cases, like monochrome cards with
> > bits_per_pixel = 8. 
> 
> It works pretty good for for any pack pixel type modes. Now for planar 
> cards this isn't the case. Ideally struct fb_cmap should have contained 

What do you mean? I don't see a problem for planar modes. A pixel is still a
value of size n bits, it's just that the n bits are not located next to each
other, but spread across multiple words. planar_imageblit() will take care of
converting from chunky to planar mode.

BTW, I do have a working amifb now (it's in Linux/m68k CVS), but the
imageblit() needs more optimizations.

> a 
> 
> unsigned long pixel;
> 
> field. Like X does. It does not and changing that would break things :-(

And let the fbdev driver fill in the pixel values, based on the fb_cmap?

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
