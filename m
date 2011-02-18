From: Jason Chen <weitway@gmail.com>
Date: Fri, 18 Feb 2011 09:22:09 +0000
Subject: Re: [PATCH 3/7] Add i.MX5 framebuffer driver
Message-Id: <AANLkTina46_CMvB_9cqc4=PvcPxaV_BQ_H_ghJZFFxg8@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
	<1297865452-32181-4-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1297865452-32181-4-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

hi, Sasha,

> +       if (var->vmode & FB_VMODE_ODD_FLD_FIRST) /* PAL */
> +               sig_cfg.odd_field_first = 1;
> +       if (var->sync & FB_SYNC_EXT)
> +               sig_cfg.ext_clk = 1;
> +       if (var->sync & FB_SYNC_HOR_HIGH_ACT)
> +               sig_cfg.Hsync_pol = 1;
Please remove FB_SYNC_EXT support.

+static void imx_ipu_fb_disable_overlay(struct fb_info *ovl)
+{
+       struct imx_ipu_fb_info *mxc_ovl = ovl->par;
+
+       if (!mxc_ovl->enabled)
+               return;
+
+       ipu_dp_disable_fg(mxc_ovl->dp);
+       ipu_wait_for_interrupt(451, 100);
+       ipu_idmac_disable_channel(mxc_ovl->ipu_ch);
+       ipu_dmfc_disable_channel(mxc_ovl->dmfc);
+       mxc_ovl->enabled = 0;
+}
Had better has a definition of ipu irq 451.

Jason Chen
BRs
