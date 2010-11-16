From: Michael Grzeschik <mgr@pengutronix.de>
Date: Tue, 16 Nov 2010 08:26:43 +0000
Subject: Re: [PATCH] lxfb: Program panel v/h sync output polarity correctly
Message-Id: <20101116082643.GB29027@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101114141231.414F29D401B@zog.reactivated.net>
In-Reply-To: <20101114141231.414F29D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Daniel,

On Sun, Nov 14, 2010 at 02:12:31PM +0000, Daniel Drake wrote:
> Commit b5c26f97ec4a17c65 introduced some breakage for the OLPC XO-1 laptop,
> differences in the output video signal after the patch caused some problems
> with the XO's display controller chip.
> 
> Reviewing of that commit against the AMD Geode LX Data Book, it seems
> that these bits were being set inversely. In both cases, active high
> output is denoted by a value of 0. See section 6.8.3.44 of the databook
> from February 2009 (Publication ID: 33234H)
> 

I rechecked the Datasheet and it seems you are right with that.
But i don't like the logical mess in the statements. So here is what i
would prefer.

> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/video/geode/lxfb_ops.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/geode/lxfb_ops.c b/drivers/video/geode/lxfb_ops.c
> index bc35a95..85ec7f6 100644
> --- a/drivers/video/geode/lxfb_ops.c
> +++ b/drivers/video/geode/lxfb_ops.c
> @@ -276,10 +276,10 @@ static void lx_graphics_enable(struct fb_info *info)
>  		write_fp(par, FP_PT1, 0);
>  		temp = FP_PT2_SCRC;
>  
> -		if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
> +		if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
>  			temp |= FP_PT2_HSP;

Instead i would like to see something like this:


		if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
                        temp &= ~(FP_PT2_HSP);

>  
> -		if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
> +		if (!(info->var.sync & FB_SYNC_VERT_HIGH_ACT))
>  			temp |= FP_PT2_VSP;

		if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
                        temp &= ~(FP_PT2_VSP);

>  
>  		write_fp(par, FP_PT2, temp);
> -- 
> 1.7.3.2

So the meaning of the switch FB_SYNC_{HOR,VERT}_HIGH_ACT stays correct
for the user, but the commits on the register act as described in the
datasheet.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
