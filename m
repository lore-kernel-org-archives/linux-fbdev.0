From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/6] atyfb: Add boot/module option
 to override composite sync
Date: Sun, 13 Mar 2005 10:04:04 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503131003090.23778@numbat.sonytel.be>
References: <200503130832.41113.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAP1K-0002Ml-Vf
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 01:04:22 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAP1J-0003gY-AO
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 01:04:22 -0800
In-Reply-To: <200503130832.41113.adaplas@hotpop.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

On Sun, 13 Mar 2005, Antonino A. Daplas wrote:
>   Some SPARC-based displays need the composite sync set to high.
>   Since none of the entries in the default db has the composite
>   sync set to high, using fb_find_mode() will produce a blank
>   display.
> 
>   Add this new option to Documentation/fb/aty128fb.txt

Wrong documentation file!

> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
> Documentation/fb/aty128fb.txt  |    1 +

aty128fb.txt is for ATI RAGE128 ...

>  drivers/video/aty/atyfb_base.c |   13 +++++++++++++

... while atyfb_base.c is for ATI Mach64.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
