From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] fbcmap.c: mark structs const or
 __read_mostly
Date: Thu, 14 Sep 2006 22:42:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0609142239590.12534@pademelon.sonytel.be>
References: <200609142159.55936.deller@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GNy2R-0001Yb-GY for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Sep 2006 13:42:23 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GNy2P-0006Lf-Ub
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Sep 2006 13:42:23 -0700
In-Reply-To: <200609142159.55936.deller@gmx.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Helge Deller <deller@gmx.de>
Cc: adaplas@pol.net, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 14 Sep 2006, Helge Deller wrote:
> - Add named initializers in fb_cmap structs and use the ARRAY_SIZE() macro

> -static struct fb_cmap default_2_colors = {
> -    0, 2, red2, green2, blue2, NULL
> +static const struct fb_cmap default_2_colors = {
> +    len:2, red:red2, green:green2, blue:blue2
>  };
> -static struct fb_cmap default_8_colors = {
> -    0, 8, red8, green8, blue8, NULL
> +static const struct fb_cmap default_8_colors = {
> +    len:8, red:red8, green:green8, blue:blue8
>  };
> -static struct fb_cmap default_4_colors = {
> -    0, 4, red4, green4, blue4, NULL
> +static const struct fb_cmap default_4_colors = {
> +    len:4, red:red4, green:green4, blue:blue4
>  };
> -static struct fb_cmap default_16_colors = {
> -    0, 16, red16, green16, blue16, NULL
> +static const struct fb_cmap default_16_colors = {
> +    len:16, red:red16, green:green16, blue:blue16
>  };

Please use the C99 variant instead of the obsolete GNU variant.

Gr{oetje,eeting}s,

						Geert

P.S. Please inline your patches, to facilitate adding review comments.
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
