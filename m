From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3][FBCON]: New Scrolling Mode: YPAN
 + REDRAW
Date: Tue, 6 Jul 2004 09:38:15 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0407060933200.3788@waterleaf.sonytel.be>
References: <200407060634.37125.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhkXL-0005FJ-2T
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 00:38:43 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BhkXK-0005QR-Fp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 00:38:42 -0700
In-Reply-To: <200407060634.37125.adaplas@hotpop.com>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 6 Jul 2004, Antonino A. Daplas wrote:
> Added a new scrolling mode (SCROLL_PAN_REDRAW) to fbcon that should greatly
> benefit unaccelerated drivers such as VESA fbdev.  An increase of 3-10 times
> in scrolling speed can be expected.

Nice!

> Using an accelerated driver, we see almost the same effect but
> not as dramatically:
>
> 1. SCROLL_MOVE - accel
> real    0m3.112s
> user    0m0.000s
> sys     0m3.112s
>
> 2. SCROLL_REDRAW - accel
> real    0m2.604s
> user    0m0.000s
> sys     0m2.603s
>
> Redraw is still faster than move, but not much.

That probably depends on the card (imageblit vs copyarea)?

> 3. SCROLL_PAN_MOVE - accel
> real    0m0.203s
> user    0m0.000s
> sys     0m0.202s
>
> 4. SCROLL_PAN_REDRAW - accel
> real    0m0.326s
> user    0m0.002s
> sys     0m0.323s
>
> This is one exception. If panning is enabled, move is
> actually faster than redraw. As to why, I don't know.

Perhaps because it's a non-overlapping copy?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
