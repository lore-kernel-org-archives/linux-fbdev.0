From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fonts
Date: Sun, 12 Jan 2003 12:25:53 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301121221140.18673-100000@vervain.sonytel.be>
References: <1042366917.1016.9.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XgGL-00067k-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Jan 2003 03:26:45 -0800
In-Reply-To: <1042366917.1016.9.camel@localhost.localdomain>
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

On 12 Jan 2003, Antonino Daplas wrote:
> On Sun, 2003-01-12 at 03:15, Geert Uytterhoeven wrote:
> > I'm trying out different fonts with amifb (based on 2.5.56 from Linus).
> >   - PEARL8x8: OK
> >   - SUN12x22: garbage (random characters)
> >   - ProFont6x11: garbage (each different line is filled with a different
> >     character)
> >   - MINI4x6: garbage (each different line is filled with a different
> >     character)
> > 
> > At first I thought it may be caused by xres and yres not divisible by the
> > fontsize, so I tried a 800x600 mode with MINI4x6. But the problem stayed the
> > same, except that only a 640x600 window in the right part of the screen was
> > used.
> > 
> > Is my planar code in amifb to blane, or have other people seen the same?
> > 
> 
> The cfb_imageblit() function exhibited the same behavior.  I think we
> both made the wrong assumption that all monochrome bitmaps are packed. I
> think the rule is:
> 
>     The first pixel on the next scanline is always at the next byte from
>     the last pixel of the current scanline.  
> 
> So a 12x22 font has 16 bits per scanline but only 12 are usable, and the
> last 4 are used as padding.  It's worse with a 4x6 fonts where the
> 4-bits are just duplicated in the other nibble.

Yes.

But that was not my problem. Currently accel_putcs() falls back to individual
character drawing if the fontwidth is not a multiple of 8, and reuses the same
struct fb_image for each call of fb_imageblit(). And since my fb_imageblit()
had a loop like `while (image->height--) { ... }' it failed. Not modifying the
passed struct fb_image fixed the problem. Yes, we need the const there :-)

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
