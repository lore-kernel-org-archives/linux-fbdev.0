From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Oops in fbcon_setup
Date: Sun, 1 Sep 2002 11:24:57 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0209011123290.6530-100000@vervain.sonytel.be>
References: <20020831222000.A205@linux-m68k.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17lQzN-0000o0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 01 Sep 2002 02:25:49 -0700
In-Reply-To: <20020831222000.A205@linux-m68k.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 31 Aug 2002, Richard Zidlicky wrote:
> I came around testing q40fb.c, fbcon_setup oopses because
> apparently dispsw isn't set anywhere.
> 
> This patch seems to fix it although I had very little opportunity 
> to test much further (it was good enough to display the next Oops
> though ;)
> 
> --- linux-m68k-2.5.x/drivers/video/q40fb.c      Tue Aug 13 21:30:36 2002
> +++ build-2.5/drivers/video/q40fb.c     Sat Aug 31 14:33:11 2002
> @@ -29,6 +29,7 @@
>  #include <asm/pgtable.h>
>  
>  #include <video/fbcon.h>
> +#include <video/fbcon-cfb16.h>
>  
>  #define Q40_PHYS_SCREEN_ADDR 0xFE800000
>  
> @@ -125,6 +126,8 @@
>         fb_info.switch_con      = gen_switch;
>         fb_info.updatevar       = gen_update_var;
>         fb_alloc_cmap(&fb_info.cmap, 16, 0);
> +
> +       display.dispsw = &fbcon_cfb16;
>  
>          gen_set_disp(-1, &fb_info);

Since fbcon_cfb16 is going to go away, what about using fbcon_accel and
cfb{copyarea,fillrect,imgblt}.c instead?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
