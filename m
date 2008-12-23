From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 2.6.27 1/2] fbdev: add E-Ink
 Broadsheet controller support
Date: Tue, 23 Dec 2008 13:52:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812231351360.17497@anakin>
References: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1LF6kS-0000Oh-HB
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 12:52:32 +0000
Received: from edna.telenet-ops.be ([195.130.132.58])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LF6kP-0004IW-J2 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 12:52:32 +0000
In-Reply-To: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, 21 Dec 2008, Jaya Kumar wrote:
> --- /dev/null
> +++ b/drivers/video/broadsheetfb.c

> +static struct fb_var_screeninfo broadsheetfb_var __devinitdata = {
> +	.xres		= DPY_W,
> +	.yres		= DPY_H,
> +	.xres_virtual	= DPY_W,
> +	.yres_virtual	= DPY_H,
> +	.bits_per_pixel	= 8,
> +	.grayscale	= 1,
> +	.nonstd		= 1,

Why do you set .nonstd?

#define FB_NONSTD_HAM           1       /* Hold-And-Modify (HAM)        */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
