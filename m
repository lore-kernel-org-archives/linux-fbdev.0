From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: FBTEST Patch
Date: Fri, 28 Nov 2003 10:21:19 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0311281020140.21469-100000@waterleaf.sonytel.be>
References: <3FC6B751.8080801@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APeoU-0005Ba-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Nov 2003 01:21:22 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1APeoT-0007DW-OR
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Nov 2003 01:21:21 -0800
In-Reply-To: <3FC6B751.8080801@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 27 Nov 2003, John Zielinski wrote:
> Here's the fbtest patch I was talking about:
> 
> diff -urNX dontdiff fbtest.old/fb.c fbtest/fb.c
> --- fbtest.old/fb.c	2003-04-04 07:07:55.000000000 -0500
> +++ fbtest/fb.c	2003-11-27 21:41:16.000000000 -0500
> @@ -18,6 +18,7 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> +#include <linux/kd.h>
>  
>  #include <asm/page.h>
>  
> @@ -47,6 +48,7 @@
>  static struct fb_cmap saved_cmap;
>  static u16 *saved_red, *saved_green, *saved_blue, *saved_transp;
>  static u8 *saved_fb;
> +static long old_mode;
>  
>  
>  static void fix_validate(void);
> @@ -396,6 +398,9 @@
>  void fb_init(void)
>  {
>      Debug("fb_init()\n");
> +    ioctl(STDOUT_FILENO, KDGETMODE, &old_mode);

You don't check for failure?

> +    if (old_mode == KD_TEXT );
> +        ioctl(STDOUT_FILENO, KDSETMODE, KD_GRAPHICS);

Note that this doesn't work if you run fbtest from a remote shell or from a
serial line, i.e. if you're not on the console.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
