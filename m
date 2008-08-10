From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev kconfig update (2nd rev)
Date: Sun, 10 Aug 2008 22:49:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808102248420.10672@anakin>
References: <20080810192207.f65de894.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0808102013500.10672@anakin>
	<20080810224832.d9d7075e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSHqp-0000Dg-K2 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 13:49:19 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSHqn-0003O2-I4
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 13:49:19 -0700
In-Reply-To: <20080810224832.d9d7075e.krzysztof.h1@poczta.fm>
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
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Update Kconfig for Permedia 2, Trident and
> 3Dfx frame buffer drivers.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> Updated patch after Geert's comments.
> 
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
> +	  The driver was tested on following cards are:
                                                   ^^^
still a bogus `are'.

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
