From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Logo code fixes part 2.
Date: Tue, 15 Feb 2005 10:11:42 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0502151011050.10480@numbat.sonytel.be>
References: <Pine.LNX.4.56.0502141821240.7796@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0ykI-0007NZ-Ap
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 01:11:50 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D0ykG-0000Uq-Dv
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 01:11:50 -0800
In-Reply-To: <Pine.LNX.4.56.0502141821240.7796@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@pentafluge.infradead.org>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 14 Feb 2005, James Simmons wrote:
> --- linus-2.6/drivers/video/logo/logo.c	2005-02-11 16:55:28.000000000 -0800
> +++ fbdev-2.6/drivers/video/logo/logo.c	2005-02-14 10:19:21.000000000 -0800
> @@ -66,8 +66,10 @@
>  		logo = &logo_linux_clut224;
>  #endif
>  #ifdef CONFIG_LOGO_DEC_CLUT224
> -		/* DEC Linux logo on MIPS/MIPS64 */
> +		/* DEC Linux logo on MIPS/MIPS64 or ALPHA */
> +#ifndef CONFIG_ALPHA
   ^^^^^^^^^^^^^^^^^^^^
Wouldn't it be more logical to put a `#ifdef CONFIG_MIPS' here?

>  		if (mips_machgroup == MACH_GROUP_DEC)
> +#endif
>  			logo = &logo_dec_clut224;
>  #endif
>  #ifdef CONFIG_LOGO_MAC_CLUT224

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
