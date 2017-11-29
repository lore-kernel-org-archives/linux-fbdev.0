From: Adam Ford <aford173@gmail.com>
Date: Wed, 29 Nov 2017 15:12:34 +0000
Subject: Re: [PATCH] omapfb: dss: Do not duplicate features data
Message-Id: <CAHCN7xKqp_8jfsXMUkF3JqPQNOwCN590PZ9RvQ9f6EJ3Z6QyMQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171129123308.GA26578@lenoch>
In-Reply-To: <20171129123308.GA26578@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Nov 29, 2017 at 6:33 AM, Ladislav Michl <ladis@linux-mips.org> wrote:
> As features data are read only, there is no need to allocate their
> copy on the heap.
>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Suggested-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  Note: This patch is not runtime tested. If you have hardware and can test
>        it, please do so and eventually add you Tested-by tag. Thank you.

Unfortunately, this fails to load properly on a Logic PD Torpedo kit
(omap3630/DM3730).

[    0.975097] omapdss_dss 48050000.dss: master bind failed: -517
[    3.821807] omapdss_dispc 48050400.dispc: Failed to allocate DISPC Features
[    3.829345] omapdss_dss 48050000.dss: failed to bind 48050400.dispc
(ops dispc_component_ops): -12
[    3.842254] omapdss_dss 48050000.dss: master bind failed: -12
[    3.848724] omapdss_dispc: probe of 48050400.dispc failed with error -12

I also get
[   12.258056] panel-dpi display: failed to find video source





>  Note2: Marcus, I hope it is okay to add your Suggested-by tag. Please
>         let me know, if I'm wrong.
>
>  drivers/video/fbdev/omap2/omapfb/dss/dispc.c    | 39 ++++++---------------
>  drivers/video/fbdev/omap2/omapfb/dss/dss.c      | 45 +++++++------------------
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c | 31 ++++-------------
>  3 files changed, 29 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> index 7a75dfda9845..6be13a106ece 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> @@ -3976,52 +3976,33 @@ static const struct dispc_features omap54xx_dispc_feats = {
>         .has_writeback          =       true,
>  };
>
> -static int dispc_init_features(struct platform_device *pdev)
> +static const struct dispc_features* dispc_get_features(void)
>  {
> -       const struct dispc_features *src;
> -       struct dispc_features *dst;
> -
> -       dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
> -       if (!dst) {
> -               dev_err(&pdev->dev, "Failed to allocate DISPC Features\n");
> -               return -ENOMEM;
> -       }
> -
>         switch (omapdss_get_version()) {
>         case OMAPDSS_VER_OMAP24xx:
> -               src = &omap24xx_dispc_feats;
> -               break;
> +               return &omap24xx_dispc_feats;
>
>         case OMAPDSS_VER_OMAP34xx_ES1:
> -               src = &omap34xx_rev1_0_dispc_feats;
> -               break;
> +               return &omap34xx_rev1_0_dispc_feats;
>
>         case OMAPDSS_VER_OMAP34xx_ES3:
>         case OMAPDSS_VER_OMAP3630:
>         case OMAPDSS_VER_AM35xx:
>         case OMAPDSS_VER_AM43xx:
> -               src = &omap34xx_rev3_0_dispc_feats;
> -               break;
> +               return &omap34xx_rev3_0_dispc_feats;
>
>         case OMAPDSS_VER_OMAP4430_ES1:
>         case OMAPDSS_VER_OMAP4430_ES2:
>         case OMAPDSS_VER_OMAP4:
> -               src = &omap44xx_dispc_feats;
> -               break;
> +               return &omap44xx_dispc_feats;
>
>         case OMAPDSS_VER_OMAP5:
>         case OMAPDSS_VER_DRA7xx:
> -               src = &omap54xx_dispc_feats;
> -               break;
> +               return &omap54xx_dispc_feats;
>
>         default:
> -               return -ENODEV;
> +               return NULL;
>         }
> -
> -       memcpy(dst, src, sizeof(*dst));
> -       dispc.feat = dst;
> -
> -       return 0;
>  }
>
>  static irqreturn_t dispc_irq_handler(int irq, void *arg)
> @@ -4078,9 +4059,9 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
>
>         spin_lock_init(&dispc.control_lock);
>
> -       r = dispc_init_features(dispc.pdev);
> -       if (r)
> -               return r;
> +       dispc.feat = dispc_get_features();
> +       if (!dispc.feat)
> +               return -ENODEV;
>
>         dispc_mem = platform_get_resource(dispc.pdev, IORESOURCE_MEM, 0);
>         if (!dispc_mem) {
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> index 48c6500c24e1..9a255ffe77c5 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> @@ -887,58 +887,37 @@ static const struct dss_features dra7xx_dss_feats = {
>         .num_ports              =       ARRAY_SIZE(dra7xx_ports),
>  };
>
> -static int dss_init_features(struct platform_device *pdev)
> +static const struct dss_features* dss_get_features(void)
>  {
> -       const struct dss_features *src;
> -       struct dss_features *dst;
> -
> -       dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
> -       if (!dst) {
> -               dev_err(&pdev->dev, "Failed to allocate local DSS Features\n");
> -               return -ENOMEM;
> -       }
> -
>         switch (omapdss_get_version()) {
>         case OMAPDSS_VER_OMAP24xx:
> -               src = &omap24xx_dss_feats;
> -               break;
> +               return &omap24xx_dss_feats;
>
>         case OMAPDSS_VER_OMAP34xx_ES1:
>         case OMAPDSS_VER_OMAP34xx_ES3:
>         case OMAPDSS_VER_AM35xx:
> -               src = &omap34xx_dss_feats;
> -               break;
> +               return &omap34xx_dss_feats;
>
>         case OMAPDSS_VER_OMAP3630:
> -               src = &omap3630_dss_feats;
> -               break;
> +               return &omap3630_dss_feats;
>
>         case OMAPDSS_VER_OMAP4430_ES1:
>         case OMAPDSS_VER_OMAP4430_ES2:
>         case OMAPDSS_VER_OMAP4:
> -               src = &omap44xx_dss_feats;
> -               break;
> +               return &omap44xx_dss_feats;
>
>         case OMAPDSS_VER_OMAP5:
> -               src = &omap54xx_dss_feats;
> -               break;
> +               return &omap54xx_dss_feats;
>
>         case OMAPDSS_VER_AM43xx:
> -               src = &am43xx_dss_feats;
> -               break;
> +               return &am43xx_dss_feats;
>
>         case OMAPDSS_VER_DRA7xx:
> -               src = &dra7xx_dss_feats;
> -               break;
> +               return &dra7xx_dss_feats;
>
>         default:
> -               return -ENODEV;
> +               return NULL;
>         }
> -
> -       memcpy(dst, src, sizeof(*dst));
> -       dss.feat = dst;
> -
> -       return 0;
>  }
>
>  static void dss_uninit_ports(struct platform_device *pdev);
> @@ -1104,9 +1083,9 @@ static int dss_bind(struct device *dev)
>
>         dss.pdev = pdev;
>
> -       r = dss_init_features(dss.pdev);
> -       if (r)
> -               return r;
> +       dss.feat = dss_get_features();
> +       if (!dss.feat)
> +               return -ENODEV;
>
>         dss_mem = platform_get_resource(dss.pdev, IORESOURCE_MEM, 0);
>         if (!dss_mem) {
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> index 9a13c35fd6d8..07d46e14cea4 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> @@ -189,47 +189,30 @@ static const struct hdmi_phy_features omap54xx_phy_feats = {
>         .max_phy        =       186000000,
>  };
>
> -static int hdmi_phy_init_features(struct platform_device *pdev)
> +static const struct hdmi_phy_features* hdmi_phy_get_features(void)
>  {
> -       struct hdmi_phy_features *dst;
> -       const struct hdmi_phy_features *src;
> -
> -       dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
> -       if (!dst) {
> -               dev_err(&pdev->dev, "Failed to allocate HDMI PHY Features\n");
> -               return -ENOMEM;
> -       }
> -
>         switch (omapdss_get_version()) {
>         case OMAPDSS_VER_OMAP4430_ES1:
>         case OMAPDSS_VER_OMAP4430_ES2:
>         case OMAPDSS_VER_OMAP4:
> -               src = &omap44xx_phy_feats;
> -               break;
> +               return &omap44xx_phy_feats;
>
>         case OMAPDSS_VER_OMAP5:
>         case OMAPDSS_VER_DRA7xx:
> -               src = &omap54xx_phy_feats;
> -               break;
> +               return &omap54xx_phy_feats;
>
>         default:
> -               return -ENODEV;
> +               return NULL;
>         }
> -
> -       memcpy(dst, src, sizeof(*dst));
> -       phy_feat = dst;
> -
> -       return 0;
>  }
>
>  int hdmi_phy_init(struct platform_device *pdev, struct hdmi_phy_data *phy)
>  {
> -       int r;
>         struct resource *res;
>
> -       r = hdmi_phy_init_features(pdev);
> -       if (r)
> -               return r;
> +       phy_feat = hdmi_phy_get_features();
> +       if (!phy_feat)
> +               return -ENODEV;
>
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
>         if (!res) {
> --
> 2.15.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
