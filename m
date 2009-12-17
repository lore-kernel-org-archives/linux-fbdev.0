From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Thu, 17 Dec 2009 16:42:45 +0000
Subject: Re: [PATCH 5/5] OMAP3EVM: Kconfig option added for selection
Message-Id: <20091217084245.9faaa19c.randy.dunlap@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <hvaibhav@ti.com>
	<1261063176-20101-1-git-send-email-hvaibhav@ti.com>
In-Reply-To: <1261063176-20101-1-git-send-email-hvaibhav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hvaibhav@ti.com
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org

On Thu, 17 Dec 2009 20:49:36 +0530 hvaibhav@ti.com wrote:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Config option added to arch/arm/plat-omap/Kconfig for selection
> of S-Video and Composite output interfaces. The default configuration would
> be S-Video.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
>  drivers/video/omap2/dss/Kconfig      |   15 +++++++++++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index e615254..549e58e 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -275,7 +275,11 @@ static struct omap_dss_device omap3_evm_tv_device = {
>  	.name			= "tv",
>  	.driver_name		= "venc",
>  	.type			= OMAP_DISPLAY_TYPE_VENC,
> +#if defined(CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO)
>  	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
> +#elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
> +	.u.venc.type		= OMAP_DSS_VENC_TYPE_COMPOSITE,

	.u or .phy ?

> +#endif
>  	.platform_enable	= omap3_evm_enable_tv,
>  	.platform_disable	= omap3_evm_disable_tv,
>  };



---
~Randy
