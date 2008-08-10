From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev kconfig update
Date: Sun, 10 Aug 2008 20:15:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808102013500.10672@anakin>
References: <20080810192207.f65de894.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSFS5-00024A-E5 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 11:15:37 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSFS3-0005lF-Pz
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 11:15:37 -0700
In-Reply-To: <20080810192207.f65de894.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 10 Aug 2008, Krzysztof Helt wrote:
> --- linux-old/drivers/video/Kconfig	2008-08-04 18:00:45.000000000 +0200
> +++ linux-mm/drivers/video/Kconfig	2008-08-10 19:15:39.463597618 +0200
> @@ -259,16 +259,24 @@ config FB_PM2
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>  	help
> -	  This is the frame buffer device driver for the Permedia2 AGP frame
> -	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
> -	  product page at
> -	  <http://www.ask.com.hk/product/Permedia%202/permedia2.htm>.
> +	  This is the frame buffer device driver for cards based on
> +	  the 3D Labs Permedia, Permedia 2 and Permedia 2V chips.
> +	  The driver was tesed on following cards are:
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
`was tested on following cards'?

> +		Diamond FireGL 1000 PRO AGP
> +		ELSA Gloria Synergy PCI
> +		Appian Jeronimo PRO (both heads) PCI
> +		3DLabs Oxygen ACX aka EONtronics Picasso P2 PCI
> +		Techsource Raptor GFX-8P (aka Sun PGX-32) on SPARC
> +		ASK Graphic Blaster Exxtreme AGP

> @@ -1629,17 +1637,16 @@ config FB_TRIDENT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>  	---help---
> -	  This driver is supposed to support graphics boards with the
> -	  Trident CyberXXXX/Image/CyberBlade chips mostly found in laptops
> +	  This is frame buffer device driver for Trident PCI/AGP chipsets.
                 ^
		 the

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
