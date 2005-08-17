From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [F]Framebuffer driver using SM501 hardware.
Date: Wed, 17 Aug 2005 14:42:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508171439060.6073@numbat.sonytel.be>
References: <20050816194825.A62AC353AB5@atlas.denx.de> <43030D41.3000508@varma-el.com>
 <Pine.LNX.4.62.0508171317540.6073@numbat.sonytel.be> <43032A76.6080104@varma-el.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E5NFJ-0006Z5-PV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 05:42:17 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E5NFI-0004Xv-C1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 05:42:17 -0700
In-Reply-To: <43032A76.6080104@varma-el.com>
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
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Wolfgang Denk <wd@denx.de>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, surendra.yadav@softdel.com

On Wed, 17 Aug 2005, Andrey Volkov wrote:
> Geert Uytterhoeven wrote:
> > On Wed, 17 Aug 2005, Andrey Volkov wrote:
> > 
> >>Todo:
> >>- 16 bpp colormap (needed reverse endian support in fbcon/fbmem)
> > 
> > 
> > Can you please elaborate? For 2.6, there should be no such problems (for 2.4,
> > there are).
> 
> Sorry for inexactitude, problem (as usually :)) in next (for case of
> MPC5200 connected through PCI to SM501): PCI on PPC (and hence SM501) is
> a little endian, PPC - big endian.
> Currently (up to 2.6.13-rc6) frame buffer routines use
> __raw_writeXX for write to fb memory. Result - garbage with colors in
> RGB565/RGB888 modes (but pixels, meanwhile, are in place). If using
> write[lw] - colors are diplayed correctly, but all image pixels are
> shifted for (RGB565). This is not bug of frame buffer, this is lack of
> some define in .config which tell fb/device driver how palette must be
> generated (more precisely it is unknown when must be RGB565, but when
> must be BGR565).

Sorry, I cannot follow.

 1. If it's a palette issue, your setcolreg() routine doesn't fill in correctly
    the pseudo palette,
 2. If it's a RGB565 vs. BGR565 issue, you don't fill in correctly the offsets
    in the color bitfields in fb_var_screeninfo,
 3. If it's an endian issue, it's RRRRRGGGGGGBBBBB vs.GGBBBBBRRRRGGGG, right?
    And then there's no much we can do...

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
