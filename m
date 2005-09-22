From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Get the line length from sysfs.
Date: Thu, 22 Sep 2005 11:38:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0509221137530.18908@numbat.sonytel.be>
References: <Pine.LNX.4.56.0509212202030.10847@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EINXd-00063u-J2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Sep 2005 02:38:57 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EINXc-0001VJ-5b
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Sep 2005 02:38:57 -0700
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j8M9cpva002736
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Sep 2005 11:38:51 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.56.0509212202030.10847@pentafluge.infradead.org>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 21 Sep 2005, James Simmons wrote:
> Let me know if this is acceptable. Some people might not like the name.
> 
> 
> --- linus-2.6/drivers/video/fbsysfs.c	2005-07-31 15:45:22.000000000 -0700
> +++ fbdev-2.6/drivers/video/fbsysfs.c	2005-09-21 13:54:02.000000000 -0700
> @@ -242,6 +242,13 @@
>  			fb_info->var.yres_virtual);
>  }
>  
> +static ssize_t show_stride(struct class_device *class_device, char *buf)
> +{
> +	struct fb_info *fb_info =
> +		(struct fb_info *)class_get_devdata(class_device);
> +	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->fix.line_length);

Do all drivers set fix.line_length these days?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
