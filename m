From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fb: clean the penguin's dirty feet
Date: Tue, 11 Nov 2008 13:27:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0811111325590.19341@anakin>
References: <4918047A.5000902@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1KzsLd-0001mB-SB
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 12:27:57 +0000
Received: from edna.telenet-ops.be ([195.130.132.58])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KzsLb-00006j-7E for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 12:27:57 +0000
In-Reply-To: <4918047A.5000902@ladisch.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 10 Nov 2008, Clemens Ladisch wrote:
> When booting in a direct color mode, the penguin has dirty feet,
> i.e., some pixels have the wrong color.  This is caused by
> fb_set_logo_directpalette() which does not initialize the last 32
> palette entries.

Nice catch!
It seems to be introduced by commit 0bcb4ab100ef9ac2afaab3e0e929314e43820fc8
("Supprt for switching hardware from/to vga text mode.", from
full-history-linux) back in 2002...

> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- linux-2.6.orig/drivers/video/fbmem.c
> +++ linux-2.6/drivers/video/fbmem.c
> @@ -232,7 +232,7 @@ static void fb_set_logo_directpalette(st
>  	greenshift = info->var.green.offset;
>  	blueshift = info->var.blue.offset;
> 
> -	for (i = 32; i < logo->clutsize; i++)
> +	for (i = 32; i < 32 + logo->clutsize; i++)
>  		palette[i] = i << redshift | i << greenshift | i << blueshift;
>  }

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
