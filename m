From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 15 Mar 2010 09:30:29 +0000
Subject: Re: [RFC][PATCH 1/3] OMAP: DSS2: Do regulator stuff in
Message-Id: <1268645429.2417.14.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
In-Reply-To: <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2010-03-12 at 16:27 +0100, Quadros Roger (Nokia-D/Helsinki)
wrote:
> From: Roger Quadros <roger.quadros@nokia.com>
> 
> We don't want dpi_init() to fail in any case as it will prevent us
> from using DSS2 if we don't have DSI in the system. This is because
> dpi_init() is done unconditionally by the DSS2 core.
> 
> We will only need to do regulator initialization when DPI is actually
> present in the system. So we do regulator init stuff in dpi_init_display()
> 
> Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
> ---
>  drivers/video/omap2/dss/dpi.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index 960e977..bcedafd 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -299,11 +299,6 @@ int dpi_init_display(struct omap_dss_device *dssdev)
>  {
>  	DSSDBG("init_display\n");
>  
> -	return 0;
> -}
> -
> -int dpi_init(struct platform_device *pdev)
> -{
>  	if (cpu_is_omap34xx()) {
>  		dpi.vdds_dsi_reg = dss_get_vdds_dsi();
>  		if (IS_ERR(dpi.vdds_dsi_reg)) {
> @@ -315,6 +310,11 @@ int dpi_init(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +int dpi_init(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +

I don't think this is quite correct. dpi_init_display() will be called
for all DPI displays, which means that it may be called more than once.
dpi_init() is meant for global initializations.

Perhaps it would be best to have DPI compiled conditionally like
SDI/DSI/RFBI.

 Tomi

Ps. Fixed the fbdev list address in the cc


