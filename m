From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 21:58:44 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310162156240.22417-100000@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAEGq-0005EP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 12:58:52 -0700
Received: from [80.88.36.193] (helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAEGp-0007bY-GU
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 12:58:51 -0700
In-Reply-To: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 15 Oct 2003, James Simmons wrote:
> Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> Several fixes. The patch is against 2.6.0-test7

> --- linux-2.6.0-test7/drivers/video/logo/Makefile	Wed Oct 15 19:12:21 2003
> +++ fbdev-2.6/drivers/video/logo/Makefile	Wed Oct 15 19:20:50 2003
> @@ -13,30 +13,36 @@
>  obj-$(CONFIG_LOGO_SUPERH_VGA16)		+= logo_superh_vga16.o
>  obj-$(CONFIG_LOGO_SUPERH_CLUT224)	+= logo_superh_clut224.o
>  
> -# Dependencies on generated files need to be listed explicitly
> -
> -$(obj)/%_mono.o: $(src)/%_mono.c
> -
> -$(obj)/%_vga16.o: $(src)/%_vga16.c
> -
> -$(obj)/%_clut224.o: $(src)/%_clut224.c
> -
> -$(obj)/%_gray256.o: $(src)/%_gray256.c
> -
> -# How to generate them
> +# mono logo's
> +$(obj)/logo_linux_mono.o:	$(obj)/logo_linux_mono.c
> +$(obj)/logo_superh_mono.o:	$(obj)/logo_superh_mono.c
> +
> +# vga16 logo's
> +$(obj)/logo_linux_vga16.o:	$(obj)/logo_linux_vga16.c
> +$(obj)/logo_superh_vga16.o:	$(obj)/logo_superh_vga16.c
> +
> +# clut224 logo's
> +$(obj)/logo_linux_clut224.o:	$(obj)/logo_linux_clut224.c
> +$(obj)/logo_dec_clut224.o:	$(obj)/logo_dec_clut224.c
> +$(obj)/logo_mac_clut224.o:	$(obj)/logo_mac_clut224.c
> +$(obj)/logo_sgi_clut224.o:	$(obj)/logo_sgi_clut224.c
> +$(obj)/logo_sun_clut224.o:	$(obj)/logo_sun_clut224.c
> +$(obj)/logo_superh_clut224.o:	$(obj)/logo_superh_clut224.c

Why did you replace the generic rules?

> --- linux-2.6.0-test7/drivers/video/radeonfb.c	Wed Oct 15 19:12:22 2003
> +++ fbdev-2.6/drivers/video/radeonfb.c	Wed Oct 15 19:20:51 2003

drivers/video/radeonfb.c still exists, while the build system now uses the one
in drivers/video/aty?

> --- linux-2.6.0-test7/drivers/video/sgivwfb.c	Wed Oct 15 19:12:22 2003
> +++ fbdev-2.6/drivers/video/sgivwfb.c	Wed Oct 15 19:20:51 2003
> @@ -319,14 +319,14 @@
>  		var->transp.length = 0;
>  		break;
>  	case 16:		/* RGBA 5551 */

Please change the comment from `RGBA 5551' to `ARGB 1555' to match the code.

> -		var->red.offset = 11;
> +		var->red.offset = 10;
>  		var->red.length = 5;
> -		var->green.offset = 6;
> +		var->green.offset = 5;
>  		var->green.length = 5;
> -		var->blue.offset = 1;
> +		var->blue.offset = 0;
>  		var->blue.length = 5;
> -		var->transp.offset = 0;
> -		var->transp.length = 0;
> +		var->transp.offset = 15;
> +		var->transp.length = 1;
>  		break;
>  	case 32:		/* RGB 8888 */
>  		var->red.offset = 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
