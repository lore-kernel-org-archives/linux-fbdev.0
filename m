From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 2/2] atmel_lcdfb: Add board
 parameter specify framebuffer memory size
Date: Fri, 8 Aug 2008 18:55:31 +0200
Message-ID: <20080808185531.b2a3aca0.krzysztof.h1@poczta.fm>
References: <200808081447.05445.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRVA4-0007bP-9y for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:49:56 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRVA3-0005F5-MG
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:49:56 -0700
In-Reply-To: <200808081447.05445.stf_xl@wp.pl>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 8 Aug 2008 14:47:05 +0200
Stanislaw Gruszka <stf_xl@wp.pl> wrote:

> Specify how much physically continuous, DMA capable memory will be allocated
> at driver initialization time. This allow to create framebuffer device with
> larger virtual resolution. Combine with y-panning this can be used to 
> implement double buffering acceleration method.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> Acked-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/atmel_lcdfb.c |    7 +++++--
>  include/video/atmel_lcdc.h  |    1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index e1acfa7..a471a60 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -242,9 +242,11 @@ static int atmel_lcdfb_alloc_video_memory(struct 
> atmel_lcdfb_info *sinfo)
>  {
>  	struct fb_info *info = sinfo->info;
>  	struct fb_var_screeninfo *var = &info->var;
> +	unsigned int smem_len;
>  
> -	info->fix.smem_len = (var->xres_virtual * var->yres_virtual
> -			    * ((var->bits_per_pixel + 7) / 8));
> +	smem_len = (var->xres_virtual * var->yres_virtual
> +		    * ((var->bits_per_pixel + 7) / 8));
> +	info->fix.smem_len = max(smem_len, sinfo->smem_len);
>  
>  	info->screen_base = dma_alloc_writecombine(info->device, info->fix.smem_len,
>  					(dma_addr_t *)&info->fix.smem_start, GFP_KERNEL);
> @@ -796,6 +798,7 @@ static int __init atmel_lcdfb_probe(struct platform_device 
> *pdev)
>  		sinfo->default_monspecs = pdata_sinfo->default_monspecs;
>  		sinfo->atmel_lcdfb_power_control = pdata_sinfo->atmel_lcdfb_power_control;
>  		sinfo->guard_time = pdata_sinfo->guard_time;
> +		sinfo->smem_len = pdata_sinfo->smem_len;
>  		sinfo->lcdcon_is_backlight = pdata_sinfo->lcdcon_is_backlight;
>  		sinfo->lcd_wiring_mode = pdata_sinfo->lcd_wiring_mode;
>  	} else {
> diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
> index 613173b..920c4e9 100644
> --- a/include/video/atmel_lcdc.h
> +++ b/include/video/atmel_lcdc.h
> @@ -41,6 +41,7 @@ struct atmel_lcdfb_info {
>  	struct work_struct	task;
>  
>  	unsigned int		guard_time;
> +	unsigned int 		smem_len;
>  	struct platform_device	*pdev;
>  	struct clk		*bus_clk;
>  	struct clk		*lcdc_clk;
> -- 
> 1.5.2.5
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

----------------------------------------------------------------------
Taniej na zagraniczne komorki!
Sprawdz >>> http://link.interia.pl/f1ece


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
