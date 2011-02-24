From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Feb 2011 08:31:52 +0000
Subject: Re: [PATCH v6] OMAP2/3/4: DSS2: Enable Display SubSystem as modules
Message-Id: <1298536312.16119.23.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298528800-7399-1-git-send-email-samreen@ti.com>
In-Reply-To: <1298528800-7399-1-git-send-email-samreen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2011-02-24 at 00:26 -0600, Nilofer, Samreen wrote:
> Enabling all the display interface options to be built as module
> And enabling all the display panels to be built as modules.
> 
> Signed-off-by: Samreen <samreen@ti.com>

This looks good to me.

Tony, want to ack this? This enables all DSS features as modules. This
should go through dss tree, as this doesn't work without a fix that is
there.

 Tomi


>  arch/arm/configs/omap2plus_defconfig |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index ae890ca..407ccf8 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -192,6 +192,17 @@ CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_MODE_HELPERS=y
>  CONFIG_FB_TILEBLITTING=y
>  CONFIG_FB_OMAP_LCD_VGA=y
> +CONFIG_OMAP2_DSS=m
> +CONFIG_OMAP2_DSS_RFBI=y
> +CONFIG_OMAP2_DSS_SDI=y
> +CONFIG_OMAP2_DSS_DSI=y
> +CONFIG_FB_OMAP2=m
> +CONFIG_PANEL_GENERIC_DPI=m
> +CONFIG_PANEL_SHARP_LS037V7DW01=m
> +CONFIG_PANEL_NEC_NL8048HL11_01B=m
> +CONFIG_PANEL_TAAL=m
> +CONFIG_PANEL_TPO_TD043MTEA1=m
> +CONFIG_PANEL_ACX565AKM=m
>  CONFIG_BACKLIGHT_LCD_SUPPORT=y
>  CONFIG_LCD_CLASS_DEVICE=y
>  CONFIG_LCD_PLATFORM=y


