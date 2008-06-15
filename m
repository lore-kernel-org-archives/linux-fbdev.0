From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: fb_videomode_to_modelist (was: Re: [PATCH]
 amifb: Register Amiga-specific video modes with sysfs)
Date: Sun, 15 Jun 2008 13:15:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806151314450.5736@anakin>
References: <Pine.LNX.4.64.0806151311200.5736@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K7qCi-0005YU-Kb for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Jun 2008 04:15:24 -0700
Received: from edna.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K7qCi-0002Y4-7m
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Jun 2008 04:15:24 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by edna.telenet-ops.be (Postfix) with SMTP id 34FF0E4028
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Jun 2008 13:15:23 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by edna.telenet-ops.be (Postfix) with ESMTP id 19BB9E4041
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Jun 2008 13:15:23 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m5FBFDU2017118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Jun 2008 13:15:13 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m5FBFDi0017115
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Jun 2008 13:15:13 +0200
In-Reply-To: <Pine.LNX.4.64.0806151311200.5736@anakin>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 15 Jun 2008, Geert Uytterhoeven wrote:
> Register the Amiga-specific video modes with sysfs, so you can see them in
> /sys/class/graphics/fb0/modes and change the video mode by writing to
> /sys/class/graphics/fb0/mode.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/video/amifb.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/drivers/video/amifb.c
> +++ b/drivers/video/amifb.c
> @@ -2383,6 +2383,9 @@ default_chipset:
>  		goto amifb_error;
>  	}
>  
> +	fb_videomode_to_modelist(ami_modedb, NUM_TOTAL_MODES,
> +				 &fb_info.modelist);
> +
>  	round_down_bpp = 0;
>  	chipptr = chipalloc(fb_info.fix.smem_len+
>  	                    SPRITEMEMSIZE+
> 

BTW, it looks like a few other drivers could use a similar change.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
