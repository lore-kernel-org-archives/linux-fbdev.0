From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 7/7] fbdev: Add Tile Blitting support
Date: Fri, 10 Sep 2004 09:58:06 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409100957130.93@waterleaf.sonytel.be>
References: <200409100534.56680.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5gLm-0001BL-Vk
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 01:01:43 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5gLQ-0001lI-PW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 01:01:24 -0700
In-Reply-To: <200409100534.56680.adaplas@hotpop.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Petr Vandrovec <vandrove@vc.cvut.cz>

On Fri, 10 Sep 2004, Antonino A. Daplas wrote:
> --- linux-2.6.9-rc1-mm4-orig/drivers/video/Kconfig	2004-09-10 04:43:22.834414192 +0800
> +++ linux-2.6.9-rc1-mm4/drivers/video/Kconfig	2004-09-10 05:01:35.555295368 +0800
> @@ -49,6 +49,24 @@ config FB_MODE_HELPERS
>  	  your driver does not take advantage of this feature, choosing Y will
>  	  just increase the kernel size by about 5K.
>
> +config FB_TILEBLITTING
> +       bool "Enable Tile Blitting Support"
> +       depends on FB
> +       default n
> +       ---help---
> +         This enables tile blitting.  Tile blitting is a drawing technique
> +	 where the screen is divided into rectangular sections (tiles), whereas
> +	 the standard blitting divides the screen into pixels. Because the
> +	 default drawing element is a tile, drawing functions will be passed
> +	 parameters in terms of number of tiles instead of number of pixels.
> +	 For example, to draw a single character, instead of using bitmaps,
> +	 an index to an array of bitmaps will be used.  To clear or move a
> +	 rectangular section of a screen, the rectangle willbe described in
                                                        ^^^^^^
							will be
> +	 terms of number of tiles in the x- and y-axis.
> +
> +	 This is particularly important to one driver, the matroxfb.  If
                                                       ^^^^^^^^^^^^
						       matroxfb?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
