From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: s3c2410fb: fix clockrate calculation
Date: Thu, 20 Aug 2009 15:19:44 -0700
Message-ID: <20090820151944.9c29607c.akpm@linux-foundation.org>
References: <20090820215047.717581584@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1MeFzD-0007tE-U4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Aug 2009 22:19:59 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeFz8-0000hH-EP
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Aug 2009 22:19:59 +0000
In-Reply-To: <20090820215047.717581584@fluff.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 20 Aug 2009 22:50:47 +0100
Ben Dooks <ben@simtec.co.uk> wrote:

> In the final part of the calculation for the tft display clockrate we
> divide the output pf s3c2410fb_calc_pixclk() by 2 which leaves us with
> a rounding error if the result is odd.
> 
> Change to using DIV_ROUND_UP() to ensure that we always choose a higher
> divisor and thus a lower frequency.
> 
> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> 
> ---
>  drivers/video/s3c2410fb.c |    4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>  
> Index: b/drivers/video/s3c2410fb.c
> ===================================================================
> --- a/drivers/video/s3c2410fb.c	2009-08-20 08:45:41.000000000 +0100
> +++ b/drivers/video/s3c2410fb.c	2009-08-20 08:45:42.000000000 +0100
> @@ -369,7 +369,9 @@ static void s3c2410fb_activate_var(struc
>  	void __iomem *regs = fbi->io;
>  	int type = fbi->regs.lcdcon1 & S3C2410_LCDCON1_TFT;
>  	struct fb_var_screeninfo *var = &info->var;
> -	int clkdiv = s3c2410fb_calc_pixclk(fbi, var->pixclock) / 2;
> +	int clkdiv;
> +
> +	clkdiv = DIV_ROUND_UP(s3c2410fb_calc_pixclk(fbi, var->pixclock), 2);
>  
>  	printk(KERN_INFO "%s: pixclock=%d, clkdiv=%d\n",
>  	       __func__, var->pixclock, clkdiv);

The changelog forgot to tell us what the impact of this bug is, so I
cannot work out whether we need this fix in 2.6.32, 2.6.31, 2.6.30.x, ....


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
