From: Grazvydas Ignotas <notasas@gmail.com>
Date: Mon, 21 Jun 2010 13:38:28 +0000
Subject: Re: [PATCH] OMAP: DSS: Fix for dsi_pll to dpll4 clk switch
Message-Id: <AANLkTim28bTkt71iKyydzg2RkusPQh8sTD_qrTun1aOf@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <FF55437E1F14DA4BAEB721A458B6701706BDA5E730@dbde02.ent.ti.com>
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDA5E730@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org

when sending DSS patches, CC Tomi and fbdev.

On Thu, Jun 17, 2010 at 8:12 AM, Nagarajan, Rajkumar <x0133774@ti.com> wrot=
e:
>
> When switching between clocks, The new functional clock is
> effective when the next vertical blanking interval occurs.
> GOLCD bit has to be set for the new clock to take effect.
>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
> ---
> =A0drivers/video/omap2/dss/dpi.c | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index 960e977..5d778d6 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -214,10 +214,15 @@ void omapdss_dpi_display_disable(struct omap_dss_de=
vice *dssdev)
>
> =A0#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
> =A0 =A0 =A0 =A0dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
> + =A0 =A0 =A0 dispc_go(OMAP_DSS_CHANNEL_LCD);
> + =A0 =A0 =A0 while =A0 (dispc_go_busy(OMAP_DSS_CHANNEL_LCD))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> =A0 =A0 =A0 =A0dsi_pll_uninit();
> =A0 =A0 =A0 =A0dss_clk_disable(DSS_CLK_FCK2);
> =A0#endif
>
> + =A0 =A0 =A0 dispc_enable_channel(OMAP_DSS_CHANNEL_LCD, 0);
> +
> =A0 =A0 =A0 =A0dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
>
> =A0 =A0 =A0 =A0if (cpu_is_omap34xx())
> --
> 1.5.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
