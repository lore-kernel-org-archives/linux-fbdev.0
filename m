From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH 8/10] fbdev: Allow core fb to be
 built as a module
Date: Mon, 7 Mar 2005 10:39:10 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503071038310.7140@numbat.sonytel.be>
References: <200503060816.55890.adaplas@hotpop.com> <20050307003620.2d844158.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Ei4-0005FO-O4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 01:39:32 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Ei3-0000Cz-14
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 01:39:32 -0800
In-Reply-To: <20050307003620.2d844158.akpm@osdl.org>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@pol.net, Antonino Daplas <adaplas@hotpop.com>, jonsmirl@gmail.com

On Mon, 7 Mar 2005, Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> >
> >    Allow the framebuffer core to be built as a module to
> >    ease debugging.
> 
> It breaks `make allmodconfig':
> 
> /tmp/distcc_1108/drivers/video/console/tileblit.c:70: undefined reference to `fb_get_buffer_offset'
> 
> 
> Seem somewhat nasty...

FB_TILEBLITTING needs to depend `properly' (it's a bool) on FB (which is
tristate).

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
