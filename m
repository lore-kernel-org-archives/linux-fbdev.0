From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: CRTC scanout buffer types
Date: Sun, 7 Aug 2005 22:42:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508072237220.31010@gorilla.sonytel.be>
References: <9e47339105080513195dee0804@mail.gmail.com> 
 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be>
 <9e47339105080706414faf1e40@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <9e47339105080706414faf1e40@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Sun, 7 Aug 2005, Jon Smirl wrote:
> I'm trying to work out a syntax for the sysfs attribute that will
> control the config. My first idea is to use a alpha/red/blue/green
> syntax. When red is set and blue/green are missing index mode is set.
> When green is set and red/blue are missing gray scale is set.

Ugh, sounds complex and non-intuitive...

> Are there chips that can scanout from buffers not packed at a power of two?

Yes, planar frame buffers can.

> How should I work different color spaces (YCbCr) into this?

That's more like a visual thing. Using a YCbCr visual, we could say the red,
green, and blue bitfields actually control Y, Cb, and Cr.

> 4bpp Index = /4
> 4bpp greyscale = //4
> 8bpp Index = /8
> 8bpp RGB 332 = /3/3/2
> 8bpp greyscale = //8
> 16bpp aRGB 1555 = 1/5/5/5
> 16bpp RGB 565 = /5/6/5
> 16bpp aRGB 4444 = 4/4/4/4
> 16bpp aIndex 88 = 8/8
> 24bpp RGB 888 = /8/8/8
> 24bpp aRGB 6666 = 6/6/6/6
> 32bpp aRGB 8888 = 8/8/8/8
> 32bpp aRGB 2:10:10:10 = 2/10/10/10

BTW, the numbers still control the lengths of the color bitfields only, not
their positions. E.g. some hardware does ARGB, other does ABGR, or BGRA...

> 1 bpp monochrome (black = 0 and white = 1 or vice versa)
> 1 bpp indexed
> 2 bpp indexed
> 3 bpp indexed
> 5 bpp indexed
> 6 bpp indexed
> 7 bpp indexed
> 
> These would have the same config, //8, right? You then just control
> what you write to the byte.

No, they use bitplanes.

> How does this work, is one 24 bit color the key?
> 32 bpp indexed+RGB 888 with color key to enable RGB888

Actually one of the CLUT index values is the color key.

So if the pixel has [ i | r | g | b ], the actual color is:

    if (i == key)
	color = [ r, g, b ];
    else
	color = [ clut.r[i], clut.g[i], clut.b[i] ];

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
