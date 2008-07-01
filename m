From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v3] video: sh7760fb: SH7760/SH7763
	LCDC framebuffer driver
Date: Tue, 1 Jul 2008 17:00:06 +0900
Message-ID: <20080701080006.GB4726@linux-sh.org>
References: <4869DC13.30604@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDapD-0000Dx-SC for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Jul 2008 01:02:55 -0700
Received: from mta23.gyao.ne.jp ([125.63.38.249] helo=mx.gate01.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KDapD-00076Q-1p
	for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Jul 2008 01:02:55 -0700
Content-Disposition: inline
In-Reply-To: <4869DC13.30604@renesas.com>
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
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: linux-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>

On Tue, Jul 01, 2008 at 04:26:11PM +0900, Nobuhiro Iwamatsu wrote:
> +====================== cut here ======================================
> +
> +#include <linux/fb.h>
> +#include <asm/sh7760fb.h>
> +
> +/*
> + * NEC NL6440bc26-01 640x480 TFT
> + * dotclock 25175 kHz
> + * Xres		640	Yres		480
> + * Htotal	800	Vtotal		525
> + * HsynStart	656	VsynStart	490
> + * HsynLenn	30	VsynLenn	2
> + *
> + * The linux framebuffer layer does not use the syncstart/synclen
> + * values but right/left/upper/lower margin values. The comments
> + * for the x_margin explain how to calculate those from given
> + * panel sync timings.
> + */
> +static struct fb_videomode nl6448bc26 = {
> +/*	.name		= "NL6448BC26",*/
> +/*	.refresh	= 60,	*/
> +	.xres		= 640,
> +	.yres		= 480,
Why are .name and .refresh commented out?

> +static void sh7760fb_wait_vsync(struct fb_info *info)
> +{
> +	struct sh7760fb_par *par = info->par;
> +
> +	if (par->pd->novsync)
> +		return;
> +}
> +
This doesn't do anything, and you never use ->novsync for anything
anywhere else either. I'd suggest killing both of them off until such a
time that you plan to do something with it.

> +	/* poll for access grant */
> +	tmo = 100;
> +	while (!(ioread16(par->base + LDPALCR) & (1 << 4)) && (--tmo))
> +		msleep(0);
> +
Err.. you are sleeping for 0ms? Just use cpu_relax() here instead if you
don't have an explicit timing requirement.

> +	if (((ldmtr & 0x003f) >= LDMTR_DSTN_MONO_8) &&
> +	    ((ldmtr & 0x003f) <= LDMTR_DSTN_COLOR_16)) {
> +
> +		pr_debug(" ***** DSTN untested! *****\n");
> +
This should still use dev_dbg() for consistency.

Looks good to me otherwise, fix those up and feel free to add a:

Reviewed-by: Paul Mundt <lethal@linux-sh.org>

to the next version.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
