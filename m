From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] - video/tridentfb.c warning fix.
Date: Fri, 16 Apr 2004 21:42:14 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404162138230.26173@waterleaf.sonytel.be>
References: <20040413164729.2eba2e6e.lcapitulino@prefeitura.sp.gov.br>
 <Pine.LNX.4.44.0404141906060.13481-100000@phoenix.infradead.org>
 <20040416152109.5bdbe325.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEZG4-0008AM-MT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Apr 2004 12:44:16 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEZG4-0004ok-A0
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Apr 2004 12:44:16 -0700
In-Reply-To: <20040416152109.5bdbe325.lcapitulino@prefeitura.sp.gov.br>
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
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 16 Apr 2004, Luiz Fernando N. Capitulino wrote:
> --- a/drivers/video/Kconfig	2004-04-16 15:02:28.000000000 -0300
> +++ a~/drivers/video/Kconfig	2004-04-16 14:46:48.000000000 -0300
> @@ -772,6 +772,13 @@ config FB_TRIDENT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tridentfb.
>
> +config FB_TRIDENT_ACCEL
> +	bool "Trident Acceleration functions (EXPERIMENTAL)"
> +	depends on FB_TRIDENT
> +	---help---
> +	This will compile FB_TRIDENT with acceleration functions.
                          ^^^^^^^^^^
the Trident frame buffer device?

> --- a/drivers/video/tridentfb.c	2004-04-16 15:02:36.000000000 -0300
> +++ a~/drivers/video/tridentfb.c	2004-04-16 14:36:00.000000000 -0300
> @@ -450,7 +450,7 @@ static struct accel_switch accel_image =
>  /*
>   * Accel functions called by the upper layers
>   */
> -
> +#ifdef FB_TRIDENT_ACCEL
>  static void tridentfb_fillrect(struct fb_info * info, const struct fb_fillrect *fr)
>  {
>  	int bpp = info->var.bits_per_pixel;
> @@ -474,6 +474,7 @@ static void tridentfb_copyarea(struct fb
>  	acc->copy_rect(ca->sx,ca->sy,ca->dx,ca->dy,ca->width,ca->height);
>  	acc->wait_engine();
>  }
> +#endif

Alternatively, you can do

    #else /* !FB_TRIDENT_ACCEL */
    #define tridentfb_fillrect	cfb_fillrect
    #define tridentfb_copyarea	cfb_copyarea
    #endif /* !FB_TRIDENT_ACCEL */

here, and get rid of the #ifdef in tridentfb_ops.

if FB_TRIDENT_ACCEL is not set, and get rid of the second #ifdef
FB_TRIDENT_ACCEL.

>  I don't know if it is good, but It will be temporary anyway,
> (just util the code is tested). The warning is gone, and the code
> can be tested.

Looks fine!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
