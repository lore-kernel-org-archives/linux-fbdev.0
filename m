From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Tue, 14 Aug 2012 12:15:30 +0000
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: cleanup cpu_is_xxxx checks
Message-Id: <CAF0AtAt9SakEnavHMFXYZ2+nPXXreGcQNyXiJ7TuarRa1tATXA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344425874-28222-1-git-send-email-cmahapatra@ti.com>
	<1344859135-4470-1-git-send-email-cmahapatra@ti.com>
In-Reply-To: <1344859135-4470-1-git-send-email-cmahapatra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

> +static const struct __initdata dispc_features omap2_dispc_features = {
> +       .hp_max                 =       256,
> +       .vp_max                 =       255,
> +       .sw_max                 =       64,
> +       .sw_start               =       5,
> +       .fp_start               =       15,
> +       .bp_start               =       27,
> +       .calc_scaling           =       dispc_ovl_calc_scaling_24xx,
> +       .calc_core_clk          =       calc_core_clk_24xx,
> +};
> +
> +static const struct __initdata dispc_features omap3_2_1_dispc_features = {
> +       .hp_max                 =       256,
> +       .vp_max                 =       255,
> +       .sw_max                 =       64,
> +       .sw_start               =       5,
> +       .fp_start               =       15,
> +       .bp_start               =       27,
> +       .calc_scaling           =       dispc_ovl_calc_scaling_34xx,
> +       .calc_core_clk          =       calc_core_clk_34xx,
> +};
> +
> +static const struct __initdata dispc_features omap3_3_0_dispc_features = {
> +       .hp_max                 =       4096,
> +       .vp_max                 =       4095,
> +       .sw_max                 =       256,
> +       .sw_start               =       7,
> +       .fp_start               =       19,
> +       .bp_start               =       31,
> +       .calc_scaling           =       dispc_ovl_calc_scaling_34xx,
> +       .calc_core_clk          =       calc_core_clk_34xx,
> +};
> +
> +static const struct __initdata dispc_features omap4_dispc_features = {
> +       .hp_max                 =       4096,
> +       .vp_max                 =       4095,
> +       .sw_max                 =       256,
> +       .sw_start               =       7,
> +       .fp_start               =       19,
> +       .bp_start               =       31,
> +       .calc_scaling           =       dispc_ovl_calc_scaling_44xx,
> +       .calc_core_clk          =       calc_core_clk_44xx,
> +};
> +

Here the dispc_features not only mention the omap name but also the
revision like omap3_3_0_dispc_features which initializes data for
OMAP3430_REV_ES3_0 and higher. May be omap34xx_rev3_0_dispc_features
is a better name for this. For others omap44xx_dispc_features kind of
name should be ok without revision number being mentioned. What d you
say?

> +static int __init dispc_init_features(struct device *dev)
> +{
> +       dispc.feat = devm_kzalloc(dev, sizeof(*dispc.feat), GFP_KERNEL);
> +       if (!dispc.feat) {
> +               dev_err(dev, "Failed to allocate DISPC Features\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (cpu_is_omap24xx()) {
> +               dispc.feat = &omap2_dispc_features;
> +       } else if (cpu_is_omap34xx()) {
> +               if (omap_rev() < OMAP3430_REV_ES3_0)
> +                       dispc.feat = &omap3_2_1_dispc_features;
> +               else
> +                       dispc.feat = &omap3_3_0_dispc_features;
> +       } else {
> +               dispc.feat = &omap4_dispc_features;
> +       }
> +
> +       return 0;
> +}
> +




-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
