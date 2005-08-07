From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: CRTC scanout buffer types
Date: Sun, 7 Aug 2005 11:43:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be>
References: <9e47339105080513195dee0804@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <9e47339105080513195dee0804@mail.gmail.com>
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: DRI developer's list <dri-devel@lists.sourceforge.net>

On Fri, 5 Aug 2005, Jon Smirl wrote:
> I've included the scanout types for the R200, what other ones are
> supported by the various chips? For example I think the R300 can
> scanout in floating point.

1 bpp monochrome (black = 0 and white = 1 or vice versa)
1 bpp indexed
2 bpp indexed
3 bpp indexed

> 4bpp Indexed

4 bpp greyscale

5 bpp indexed
6 bpp indexed
7 bpp indexed

> 8bpp Indexed

8 bpp monochrome (black is all zeroes and white is all ones or vice versa)
8 bpp greyscale
8 bpp RGB 332

> 16bpp aRGB 1555
> 16bpp RGB 565
> 16bpp aRGB 4444

> 24bpp RGB 888

24 bpp aRGB 6666

> 32bpp aRGB 8888

32 bpp indexed+RGB 888 with color key to enable RGB888

> 16bpp aIndex 88

This one is a new one for me ;-)

> 32bpp aRGB 2:10:10:10 palette bypassed

And of course all the various YCbCr (4:4:4, 4:2:2, 4:2:0) variants, which just
need a few additional FB_VISUAL_* defines :-)

Probably I forgot a few. Feel free to add them.

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
