From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 14 Feb 2013 12:45:38 +0000
Subject: Re: [PATCH 27/33] OMAPDSS: n8x0 panel: handle gpio data in panel driver
Message-Id: <20130214124538.GB4499@blackmetal.musicnaut.iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
 <1360765345-19312-28-git-send-email-archit@ti.com>
 <20130213173527.GE21750@blackmetal.musicnaut.iki.fi>
 <511C8578.1070907@ti.com>
In-Reply-To: <511C8578.1070907@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Feb 14, 2013 at 12:04:32PM +0530, Archit Taneja wrote:
> On Wednesday 13 February 2013 11:05 PM, Aaro Koskinen wrote:
> >On Wed, Feb 13, 2013 at 07:52:19PM +0530, Archit Taneja wrote:
> >>@@ -444,6 +445,20 @@ static int n8x0_panel_probe(struct omap_dss_device *dssdev)
> >>  	dssdev->ctrl.rfbi_timings = n8x0_panel_timings;
> >>  	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
> >>
> >>+	if (gpio_is_valid(bdata->panel_reset)) {
> >>+		r = devm_gpio_request_one(&dssdev->dev, bdata->panel_reset,
> >>+				GPIOF_OUT_INIT_LOW, "PANEL RESET");
> >>+		if (r)
> >>+			return r;
> >>+	}
> >>+
> >>+	if (gpio_is_valid(bdata->ctrl_pwrdown)) {
> >>+		r = devm_gpio_request_one(&dssdev->dev, bdata->ctrl_pwrdown,
> >>+				GPIOF_OUT_INIT_LOW, "PANEL PWRDOWN");
> >>+		if (r)
> >>+			return r;
> >>+	}
> >>+
> >
> >In the error case, the other GPIO is not freed. Also maybe you should
> >free them on module removal, because now the module owns the GPIOs.
> 
> Wouldn't the usage of devm_* functions take care of this? If the
> device isn't registered successfully, then all allocations/requests
> done using devm_* functions will be free'd automatically.

Sorry, I didn't realized they are devm_* now. You are right.

A.
