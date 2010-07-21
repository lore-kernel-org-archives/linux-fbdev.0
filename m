From: Igor Grinberg <grinberg@compulab.co.il>
Date: Wed, 21 Jul 2010 14:36:11 +0000
Subject: Re: [PATCH] [ARM] video/omap2/tdo35s: fix visual artefacts
Message-Id: <4C4705DB.4000402@compulab.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278931370-19912-1-git-send-email-grinberg@compulab.co.il>
In-Reply-To: <1278931370-19912-1-git-send-email-grinberg@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

ping!
> TDO35S samples the data on the falling adge of the pixel clock,
> therefore the data strobe should be on the raising edge.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  .../video/omap2/displays/panel-toppoly-tdo35s.c    |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> index fa434ca..e320e67 100644
> --- a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> +++ b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> @@ -73,8 +73,12 @@ static void toppoly_tdo_panel_power_off(struct omap_dss_device *dssdev)
>  
>  static int toppoly_tdo_panel_probe(struct omap_dss_device *dssdev)
>  {
> -	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> -		OMAP_DSS_LCD_IHS;
> +	dssdev->panel.config = OMAP_DSS_LCD_TFT |
> +			       OMAP_DSS_LCD_IVS |
> +			       OMAP_DSS_LCD_IHS |
> +			       OMAP_DSS_LCD_IPC |
> +			       OMAP_DSS_LCD_ONOFF;
> +
>  	dssdev->panel.timings = toppoly_tdo_panel_timings;
>  
>  	return 0;
>   

-- 
Regards,
Igor.

