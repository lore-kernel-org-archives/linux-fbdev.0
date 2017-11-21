From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Nov 2017 10:25:30 +0000
Subject: Re: [PATCH v2 4/4] drm: omapdrm: Fix DPI on platforms using the DSI VDDS
Message-Id: <7f34033e-4af7-f5f5-47ef-759249ddfe39@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1510822218.git.hns@goldelico.com>
 <dd2427920427440e051951071377265fc0a830d4.1510822218.git.hns@goldelico.com>
In-Reply-To: <dd2427920427440e051951071377265fc0a830d4.1510822218.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 16/11/17 10:50, H. Nikolaus Schaller wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Commit d178e034d565 ("drm: omapdrm: Move FEAT_DPI_USES_VDDS_DSI feature
> to dpi code") replaced usage of platform data version with SoC matching
> to configure DPI VDDS. The SoC match entries were incorrect, they should
> have matched on the machine name instead of the SoC family. Fix it.
> 
> The result was observed on OpenPandora with OMAP3530 where the panel only
> had the Blue channel and Red&Green were missing. It was not observed on
> GTA04 with DM3730.
> 
> Fixes: d178e034d565 ("drm: omapdrm: Move FEAT_DPI_USES_VDDS_DSI feature to dpi code")
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/dpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dpi.c b/drivers/gpu/drm/omapdrm/dss/dpi.c
> index 4ed5fde11313..a91e5f1a0490 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dpi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dpi.c
> @@ -566,8 +566,8 @@ static int dpi_verify_pll(struct dss_pll *pll)
>  }
>  
>  static const struct soc_device_attribute dpi_soc_devices[] = {
> -	{ .family = "OMAP3[456]*" },
> -	{ .family = "[AD]M37*" },
> +	{ .machine = "OMAP3[456]*" },
> +	{ .machine = "[AD]M37*" },
>  	{ /* sentinel */ }
>  };
>  
> 

I have picked this one. I think the rest of the patches are more of a
cleanup, right? And you'll be sending v3 at some point.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
