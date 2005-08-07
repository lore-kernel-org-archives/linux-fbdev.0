From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Choosing the correct framebuffer configuration
Date: Sun, 7 Aug 2005 11:48:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508071145100.31010@gorilla.sonytel.be>
References: <9e473391050805184756f055ea@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1hrD-0002NJ-4S
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 02:54:15 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1hrC-0003Je-RJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 02:54:15 -0700
In-Reply-To: <9e473391050805184756f055ea@mail.gmail.com>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 5 Aug 2005, Jon Smirl wrote:
> The chips actually allow nine configs (maybe more when I get a look at
> the R300 doc). It is ambiguous to set these configs based on BPP since
> there are multiple configs for various BPP. These configs should
> instead be set with the transp/red/blue/green fields.
> 
> 4bpp Index = /4
> 8bpp Index = /8
> 16bpp aRGB 1555 = 1/5/5/5
> 16bpp RGB 565 = /5/6/5
> 16bpp aRGB 4444 = 4/4/4/4
> 16bpp aIndex 88 = 8/8
> 24bpp RGB 888 = /8/8/8
> 32bpp aRGB 8888 = 8/8/8/8
> 32bpp aRGB 2:10:10:10 = 2/10/10/10
> 
> What is the best way to fix this?

Just follow the FBIOPUT_VSCREENINFO rules:
  - If a value doesn't fit, round it up.
  - If rounding is impossible, return an error.

So if a user asks for e.g. bpp 16, transp.length = 1,
{red,green,blue}.length = 0, you can give him 1555 if your hardware supports
it. Or 4444 if your hardware doesn't support anything in between 1000 and 4444
(w.r.t. rounding). But you must not give him 565, since this implies you
rounded down transp.length.

> The interesting hidden config is 30b color.

Piece of cake!

    bpp = 32
    transp.length = 2, {red,green,blue}.length = 10

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
