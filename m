From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 22 Dec 2009 11:59:14 +0000
Subject: Re: [PATCH 1/5] dss2-core:Warning Fix: core_dump_clocks enclosed
Message-Id: <1261483154.2108.86.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <hvaibhav@ti.com>
	 <1261063105-19874-1-git-send-email-hvaibhav@ti.com>
In-Reply-To: <1261063105-19874-1-git-send-email-hvaibhav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

On Thu, 2009-12-17 at 16:18 +0100, ext hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Which warning does this fix? I don't get any compiler warnings.

Can you change the name of the patch to a more standard one?

 Tomi

> ---
>  drivers/video/omap2/dss/core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 29497a0..2fabaf2 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -124,6 +124,7 @@ static void restore_all_ctx(void)
>  	dss_clk_disable_all_no_ctx();
>  }
>  
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
>  /* CLOCKS */
>  static void core_dump_clocks(struct seq_file *s)
>  {
> @@ -149,6 +150,7 @@ static void core_dump_clocks(struct seq_file *s)
>  				clocks[i]->usecount);
>  	}
>  }
> +#endif /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) */
>  
>  static int dss_get_clock(struct clk **clock, const char *clk_name)
>  {


