From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/2] atmel_lcdfb: Set ypanstep to 1
 and enable y-panning on AT91
Date: Fri, 8 Aug 2008 18:44:32 +0200
Message-ID: <20080808184432.1c1b2c4d.krzysztof.h1@poczta.fm>
References: <200808081446.43406.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRUzN-0006QD-NP for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:38:55 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRUzN-0004q7-8x
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:38:53 -0700
In-Reply-To: <200808081446.43406.stf_xl@wp.pl>
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
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 8 Aug 2008 14:46:43 +0200
Stanislaw Gruszka <stf_xl@wp.pl> wrote:

> Panning in the y-direction can be done by simply changing the DMA base
> address. This code is already in place, but FBIOPAN_DISPLAY will
> currently fail because ypanstep is 0.
> 
> Set ypanstep to 1 to indicate that we do support y-panning and also
> set the necessary acceleration flags on AT91 (AVR32 already have
> them.)
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> ---

Probably you both (Haavard and Stanislaw) should sign-off this patch.

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/atmel_lcdfb.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 5b3a15d..e1acfa7 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -39,7 +39,9 @@
>  #endif
>  
>  #if defined(CONFIG_ARCH_AT91)
> -#define	ATMEL_LCDFB_FBINFO_DEFAULT	FBINFO_DEFAULT
> +#define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
> +					 | FBINFO_PARTIAL_PAN_OK \
> +					 | FBINFO_HWACCEL_YPAN)
>  
>  static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
>  					struct fb_var_screeninfo *var)
> @@ -177,7 +179,7 @@ static struct fb_fix_screeninfo atmel_lcdfb_fix __initdata 
> = {
>  	.type		= FB_TYPE_PACKED_PIXELS,
>  	.visual		= FB_VISUAL_TRUECOLOR,
>  	.xpanstep	= 0,
> -	.ypanstep	= 0,
> +	.ypanstep	= 1,
>  	.ywrapstep	= 0,
>  	.accel		= FB_ACCEL_NONE,
>  };
> -- 
> 1.5.2.5
> 
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
Tylko dla detektywow! Konkurs na Smaker.pl
Kliknij >>> http://link.interia.pl/f1eb1


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
