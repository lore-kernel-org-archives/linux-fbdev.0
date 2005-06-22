From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] New framebuffer fonts + updated 12x22 font available
Date: Wed, 22 Jun 2005 11:57:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0506221156540.16901@numbat.sonytel.be>
References: <200506220308.j5M380Ru002576@hera.kernel.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dl1zy-0006KY-7j
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Jun 2005 02:58:22 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dl1zw-0000PP-Hd
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Jun 2005 02:58:22 -0700
In-Reply-To: <200506220308.j5M380Ru002576@hera.kernel.org>
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
To: Jurriaan <thunder7@xs4all.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 21 Jun 2005, Linux Kernel Mailing List wrote:
> [PATCH] New framebuffer fonts + updated 12x22 font available
> 
> Improve the fonts for use with the framebuffer.
> 
> I've added all the characters marked 'FIXME' in the sun12x22 font and
> created a 10x18 font (based on the sun12x22 font) and a 7x14 font (based
> on the vga8x16 font).
> 
> This patch is non-intrusive, no options are enabled by default so most
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> users won't notice a thing.

But ...

> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -153,6 +153,15 @@ config FONT_6x11
>  	  Small console font with Macintosh-style high-half glyphs.  Some Mac
>  	  framebuffer drivers don't support this one at all.
>  
> +config FONT_7x14
> +	bool "console 7x14 font (not supported by all drivers)" if FONTS
> +	depends on FRAMEBUFFER_CONSOLE
> +	default y if !SPARC32 && !SPARC64 && !FONTS
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Sorry I didn't nocice during the original review...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
