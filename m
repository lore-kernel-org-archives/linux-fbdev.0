From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Fri, 2 May 2003 11:27:11 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0305021122580.5423-100000@vervain.sonytel.be>
References: <20030501140415.A4518@heavens.murgatroid.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19BWqh-0002y7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 02 May 2003 02:28:59 -0700
In-Reply-To: <20030501140415.A4518@heavens.murgatroid.com>
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
To: Christopher Hoover <ch@murgatroid.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 1 May 2003, Christopher Hoover wrote:
> Here's a patch, close to a complete rewrite, that makes the Epson
> 1355/SED355/S1D1305 work under 2.5.  I tested it thoroughly in 5/6/5
> truecolor mode on a Ceiva.
> 
> N.B., I hacked cfb* a bit so that I could use that code with my own
> versions of fb_{read|write}*.  This was necessary as this controller
> only supports 16-bit accesses (at least on ARM ep7212-based Ceiva
> platform).
> --- linux-2.5.68-rmk1/drivers/video/cfbcopyarea.c	2003-04-19 19:50:46.000000000 -0700
> +++ linux-2.5.68-rmk1-ceiva1/drivers/video/cfbcopyarea.c	2003-04-24 14:27:52.000000000 -0700
> @@ -29,16 +29,31 @@
>  #include <asm/types.h>
>  #include <asm/io.h>
>  
> +/* this file may be included verbatim, with your own
> + *  fb_{read,write}{l,q} routines, if you define CFB_COPYAREA and 
> + * _FB_{READ|WRITE}{Q|L} 
> + */
> +#ifndef CFB_COPYAREA
> +#  define CFB_COPYAREA cfb_copyarea
> +#  define CFB_COPYAREA_STATIC
> +#  define _FB_WRITEL fb_writel
> +#  define _FB_READL fb_readl
> +#  define _FB_WRITEQ fb_writeq
> +#  define _FB_READQ _fb_readq
> +#else
> +#  define CFB_COPYAREA_STATIC static
> +#endif
> +
>  #define LONG_MASK  (BITS_PER_LONG - 1)

> +#ifndef CFB_COPYAREA

This won't work, as CFB_COPYAREA is always defined here.
Better add a `#define DO_EXPORTS' above and change it to DO_EXPORTS.

>  EXPORT_SYMBOL(cfb_copyarea);
>  
>  MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
>  MODULE_DESCRIPTION("Generic software accelerated copyarea");
>  MODULE_LICENSE("GPL");
> -
> +#endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
