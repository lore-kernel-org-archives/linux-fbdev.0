From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Mon, 24 Jun 2013 14:37:37 +0000
Subject: Re: [PATCH 2/2] fb: fix atyfb unused data warnings
Message-Id: <20130624143737.GI305@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51C26B56.20802@infradead.org>
In-Reply-To: <51C26B56.20802@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On 19:39 Wed 19 Jun     , Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix compiler warnings of data defined but not used.  They are only used
> with certain kconfig settings.
> 
> drivers/video/aty/atyfb_base.c:534:13: warning: 'ram_dram' defined but not used [-Wunused-variable]
> drivers/video/aty/atyfb_base.c:535:13: warning: 'ram_resv' defined but not used [-Wunused-variable]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc:	Paul Mackerras <paulus@samba.org>
> Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc:	linux-fbdev@vger.kernel.org
> Cc:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/aty/atyfb_base.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-next-20130619.orig/drivers/video/aty/atyfb_base.c
> +++ linux-next-20130619/drivers/video/aty/atyfb_base.c
> @@ -531,8 +531,10 @@ static int correct_chipset(struct atyfb_
>  	return 0;
>  }
>  
> +#if defined(CONFIG_FB_ATY_GX) || defined(CONFIG_FB_ATY_CT)
>  static char ram_dram[] = "DRAM";
>  static char ram_resv[] = "RESV";
use __maybe_unused macro instead of the ifdef
> +#endif
>  #ifdef CONFIG_FB_ATY_GX
>  static char ram_vram[] = "VRAM";
>  #endif /* CONFIG_FB_ATY_GX */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
