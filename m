From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/2] atmel_lcdfb: Disallow to set
 larger resolution than framebuffer memory can handle
Date: Fri, 05 Sep 2008 09:25:16 +0200
Message-ID: <48C0DEDC.8050302@atmel.com>
References: <200809031537.40702.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbVhW-0003C2-Km for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 00:25:50 -0700
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KbVhW-0006Aa-09
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 00:25:50 -0700
In-Reply-To: <200809031537.40702.stf_xl@wp.pl>
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
To: Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Morton <akpm@linux-foundation.org>
Cc: krzysztof.h1@wp.pl, linux-fbdev-devel@lists.sourceforge.net, Haavard Skinnemoen <hskinnemoen@atmel.com>

Stanislaw Gruszka :
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/video/atmel_lcdfb.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 3376f35..5d6cf33 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -342,6 +342,13 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
>  	var->transp.offset = var->transp.length = 0;
>  	var->xoffset = var->yoffset = 0;
>  
> +	if (info->fix.smem_len) {
> +		unsigned int smem_len = (var->xres_virtual * var->yres_virtual
> +					 * ((var->bits_per_pixel + 7) / 8));
> +		if (smem_len > info->fix.smem_len)
> +			return -EINVAL;
> +	}
> +
>  	/* Saturate vertical and horizontal timings at maximum values */
>  	var->vsync_len = min_t(u32, var->vsync_len,
>  			(ATMEL_LCDC_VPW >> ATMEL_LCDC_VPW_OFFSET) + 1);


-- 
Nicolas Ferre


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
