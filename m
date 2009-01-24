From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb: hide cursor in graphics mode
Date: Sat, 24 Jan 2009 09:51:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901240951110.13803@anakin>
References: <46e1c7760901230433i3045f273oa109ce97e790bca3@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758660AbZAXIwR@vger.kernel.org>
In-Reply-To: <46e1c7760901230433i3045f273oa109ce97e790bca3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Risto Suominen <risto.suominen@gmail.com>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

On Fri, 23 Jan 2009, Risto Suominen wrote:
> Xserver Xfbdev (kdrive) uses linux framebuffer in graphics mode. It doesn't
> need the text mode cursor, it's a bit annoying to have it there sitting in a
> corner. This patch disables the cursor even when in graphics mode.
> 
> Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
> ---
> The testing is done on kernel version 2.6.18.

Which is well... quite old.

Does it also (still) happen with 2.6.28?

> --- a/drivers/video/console/fbcon.c.org	2007-03-03 07:14:54.000000000 +0200
> +++ b/drivers/video/console/fbcon.c	2009-01-23 12:42:14.000000000 +0200
> @@ -1363,6 +1363,12 @@ static void fbcon_cursor(struct vc_data
>  	int y;
>   	int c = scr_readw((u16 *) vc->vc_pos);
> 
> +	if (mode == CM_ERASE && info->fbops->fb_cursor) {
> +		/* Hide H/W-cursor unconditionally */
> +		ops->cursor(vc, info, mode, 0, 0, 0);
> +		return;
> +	}
> +
>  	if (fbcon_is_inactive(vc, info))
>  		return;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
