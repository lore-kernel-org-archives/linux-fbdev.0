From: James Simmons <jsimmons@infradead.org>
Subject: Re: PPC64 prom logo
Date: Mon, 24 Mar 2003 11:42:24 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0303241142210.11533-100000@maxwell.earthlink.net>
References: <Pine.GSO.4.21.0303231141590.9116-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xX16-0007Hr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Mar 2003 10:49:52 -0800
In-Reply-To: <Pine.GSO.4.21.0303231141590.9116-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC64 Development <linuxppc64-dev@lists.linuxppc.org>


Applied.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On Sun, 23 Mar 2003, Geert Uytterhoeven wrote:

>
> Sorry, it seems I missed a RELOC in the PPC64 prom logo code. Is this (patch
> against current BK) OK?
>
> --- linux-2.5.x/arch/ppc64/kernel/prom.c.orig	Sun Mar 23 11:37:52 2003
> +++ linux-2.5.x/arch/ppc64/kernel/prom.c	Sun Mar 23 11:39:35 2003
> @@ -1271,7 +1271,8 @@
>
>  #ifdef CONFIG_FB_LOGO_LINUX_CLUT224
>  		clut = RELOC(RELOC(&logo_linux_clut224)->clut);
> -		for (i = 0; i < logo_linux_clut224.clutsize; i++, clut += 3)
> +		for (i = 0; i < RELOC(&logo_linux_clut224)->clutsize;
> +		     i++, clut += 3)
>  			if (prom_set_color(ih, i + 32, clut[0], clut[1],
>  					   clut[2]) != 0)
>  				break;
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
>
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
