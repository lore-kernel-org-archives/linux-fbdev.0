From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Typo in drivers/video/modedb.c
Date: Sat, 25 Oct 2008 18:16:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810251816040.15317@anakin>
References: <49033AE4.3000502@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463808415-1685231847-1224951376=:15317"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753811AbYJYQQ4@vger.kernel.org>
In-Reply-To: <49033AE4.3000502@gmail.com>
Content-ID: <Pine.LNX.4.64.0810251816360.15317@anakin>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: =?UTF-8?B?SmnFmcOtIE1vcmF2ZWM=?= <jim.lkml@gmail.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808415-1685231847-1224951376=:15317
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-ID: <Pine.LNX.4.64.0810251816361.15317@anakin>

On Sat, 25 Oct 2008, Ji�~Yí Moravec wrote:
> When I viewed drivers/video/modedb.c, so I accidentally noticed a very old typo already contained in 2.6.0.
> This typo remained unheeded at least 5 years. Clear evidence of its importance.  ;) 

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
> diff -Nupr a/drivers/video/modedb.c b/drivers/video/modedb.c
> --- a/drivers/video/modedb.c	2008-10-25 16:18:00.000000000 +0200
> +++ b/drivers/video/modedb.c	2008-10-25 16:18:10.000000000 +0200
> @@ -329,7 +329,7 @@ const struct fb_videomode vesa_modes[] =
>  	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
>  	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
>  	/* 17 1152x864-75 VESA */
> -	{ NULL, 75, 1153, 864, 9259, 256, 64, 32, 1, 128, 3,
> +	{ NULL, 75, 1152, 864, 9259, 256, 64, 32, 1, 128, 3,
>  	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
>  	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
>  	/* 18 1280x960-60 VESA */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---1463808415-1685231847-1224951376=:15317--
