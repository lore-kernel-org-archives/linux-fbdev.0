From: Marek Vasut <marex@denx.de>
Date: Mon, 18 Mar 2013 18:23:17 +0000
Subject: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
Message-Id: <1363630997-5254-1-git-send-email-marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5AwD7Q3G+xp9DW0vioZnHZJX538nFeE9F-P+jbHMHPqoQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AwD7Q3G+xp9DW0vioZnHZJX538nFeE9F-P+jbHMHPqoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

The issue fixed by this patch manifests only then using X11
with mxsfb driver. The X11 will display either shifted image
or otherwise distorted image on the LCD.

The problem is that the X11 tries to reconfigure the framebuffer
and along the way calls fb_ops.fb_set_par() with X11's desired
configuration values. The field of particular interest is
fb_info->var.sync which contains non-standard values if
configured by kernel. These are either FB_SYNC_DATA_ENABLE_HIGH_ACT,
FB_SYNC_DOTCLK_FAILING_ACT or both, depending on the platform
configuration. Both of these values are defined in the
include/linux/mxsfb.h file.

The driver interprets these values and configures the LCD controller
accordingly. Yet X11 only has access to the standard values for this
field defined in include/uapi/linux/fb.h and thus, unlike kernel,
omits these special values. This results in distorted image on the
LCD.

This patch moves these non-standard values into new field of the
mxsfb_platform_data structure so the driver can in turn check this
field instead of the video mode field for these specific portions.

Moreover, this patch prefixes these values with MXSFB_SYNC_ prefix
instead of FB_SYNC_ prefix to prevent confusion of subsequent users.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux FBDEV <linux-fbdev@vger.kernel.org>
Cc: Lothar Wa=C3=9Fmann <LW@karo-electronics.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/mach-mxs.c |   22 +++++++++++-----------
 drivers/video/mxsfb.c        |    7 +++++--
 include/linux/mxsfb.h        |    7 +++++--
 3 files changed, 21 insertions(+), 15 deletions(-)

NOTE: This is the version for stable v3.8.3, so I'm sending it to -stable.
      I will send adjusted version for mainline 3.9-rc , since there is
      one more board in mainline and therefore the versions of the patch
      must differ.

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index c66129b..ebf592c 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -41,8 +41,6 @@ static struct fb_videomode mx23evk_video_modes[] =3D {
 		.lower_margin	=3D 4,
 		.hsync_len	=3D 1,
 		.vsync_len	=3D 1,
-		.sync		=3D FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
 	},
 };
=20
@@ -59,8 +57,6 @@ static struct fb_videomode mx28evk_video_modes[] =3D {
 		.lower_margin	=3D 10,
 		.hsync_len	=3D 10,
 		.vsync_len	=3D 10,
-		.sync		=3D FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
 	},
 };
=20
@@ -77,7 +73,6 @@ static struct fb_videomode m28evk_video_modes[] =3D {
 		.lower_margin	=3D 45,
 		.hsync_len	=3D 1,
 		.vsync_len	=3D 1,
-		.sync		=3D FB_SYNC_DATA_ENABLE_HIGH_ACT,
 	},
 };
=20
@@ -94,9 +89,7 @@ static struct fb_videomode apx4devkit_video_modes[] =3D {
 		.lower_margin	=3D 13,
 		.hsync_len	=3D 48,
 		.vsync_len	=3D 3,
-		.sync		=3D FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT |
-				  FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
+		.sync		=3D FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	},
 };
=20
@@ -113,9 +106,7 @@ static struct fb_videomode apf28dev_video_modes[] =3D {
 		.lower_margin =3D 0x15,
 		.hsync_len =3D 64,
 		.vsync_len =3D 4,
-		.sync =3D FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT |
-				FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				FB_SYNC_DOTCLK_FAILING_ACT,
+		.sync =3D FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	},
 };
=20
@@ -250,6 +241,8 @@ static void __init imx23_evk_init(void)
 	mxsfb_pdata.mode_count =3D ARRAY_SIZE(mx23evk_video_modes);
 	mxsfb_pdata.default_bpp =3D 32;
 	mxsfb_pdata.ld_intf_width =3D STMLCDIF_24BIT;
+	mxsfb_pdata.sync =3D MXSFB_SYNC_DATA_ENABLE_HIGH_ACT |
+				MXSFB_SYNC_DOTCLK_FAILING_ACT;
 }
=20
 static inline void enable_clk_enet_out(void)
@@ -269,6 +262,8 @@ static void __init imx28_evk_init(void)
 	mxsfb_pdata.mode_count =3D ARRAY_SIZE(mx28evk_video_modes);
 	mxsfb_pdata.default_bpp =3D 32;
 	mxsfb_pdata.ld_intf_width =3D STMLCDIF_24BIT;
+	mxsfb_pdata.sync =3D MXSFB_SYNC_DATA_ENABLE_HIGH_ACT |
+				MXSFB_SYNC_DOTCLK_FAILING_ACT;
=20
 	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
 }
@@ -288,6 +283,7 @@ static void __init m28evk_init(void)
 	mxsfb_pdata.mode_count =3D ARRAY_SIZE(m28evk_video_modes);
 	mxsfb_pdata.default_bpp =3D 16;
 	mxsfb_pdata.ld_intf_width =3D STMLCDIF_18BIT;
+	mxsfb_pdata.sync =3D MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
 }
=20
 static void __init sc_sps1_init(void)
@@ -313,6 +309,8 @@ static void __init apx4devkit_init(void)
 	mxsfb_pdata.mode_count =3D ARRAY_SIZE(apx4devkit_video_modes);
 	mxsfb_pdata.default_bpp =3D 32;
 	mxsfb_pdata.ld_intf_width =3D STMLCDIF_24BIT;
+	mxsfb_pdata.sync =3D MXSFB_SYNC_DATA_ENABLE_HIGH_ACT |
+				MXSFB_SYNC_DOTCLK_FAILING_ACT;
 }
=20
 #define ENET0_MDC__GPIO_4_0	MXS_GPIO_NR(4, 0)
@@ -403,6 +401,8 @@ static void __init apf28_init(void)
 	mxsfb_pdata.mode_count =3D ARRAY_SIZE(apf28dev_video_modes);
 	mxsfb_pdata.default_bpp =3D 16;
 	mxsfb_pdata.ld_intf_width =3D STMLCDIF_16BIT;
+	mxsfb_pdata.sync =3D MXSFB_SYNC_DATA_ENABLE_HIGH_ACT |
+				MXSFB_SYNC_DOTCLK_FAILING_ACT;
 }
=20
 static void __init mxs_machine_init(void)
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 755556c..45169cb 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -169,6 +169,7 @@ struct mxsfb_info {
 	unsigned dotclk_delay;
 	const struct mxsfb_devdata *devdata;
 	int mapped;
+	u32 sync;
 };
=20
 #define mxsfb_is_v3(host) (host->devdata->ipversion =3D 3)
@@ -456,9 +457,9 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 		vdctrl0 |=3D VDCTRL0_HSYNC_ACT_HIGH;
 	if (fb_info->var.sync & FB_SYNC_VERT_HIGH_ACT)
 		vdctrl0 |=3D VDCTRL0_VSYNC_ACT_HIGH;
-	if (fb_info->var.sync & FB_SYNC_DATA_ENABLE_HIGH_ACT)
+	if (host->sync & MXSFB_SYNC_DATA_ENABLE_HIGH_ACT)
 		vdctrl0 |=3D VDCTRL0_ENABLE_ACT_HIGH;
-	if (fb_info->var.sync & FB_SYNC_DOTCLK_FAILING_ACT)
+	if (host->sync & MXSFB_SYNC_DOTCLK_FAILING_ACT)
 		vdctrl0 |=3D VDCTRL0_DOTCLK_ACT_FAILING;
=20
 	writel(vdctrl0, host->base + LCDC_VDCTRL0);
@@ -861,6 +862,8 @@ static int mxsfb_probe(struct platform_device *pdev)
=20
 	INIT_LIST_HEAD(&fb_info->modelist);
=20
+	host->sync =3D pdata->sync;
+
 	ret =3D mxsfb_init_fbinfo(host);
 	if (ret !=3D 0)
 		goto error_init_fb;
diff --git a/include/linux/mxsfb.h b/include/linux/mxsfb.h
index f14943d..f80af86 100644
--- a/include/linux/mxsfb.h
+++ b/include/linux/mxsfb.h
@@ -24,8 +24,8 @@
 #define STMLCDIF_18BIT 2 /** pixel data bus to the display is of 18 bit wi=
dth */
 #define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit wi=
dth */
=20
-#define FB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
-#define FB_SYNC_DOTCLK_FAILING_ACT	(1 << 7) /* failing/negtive edge sampli=
ng */
+#define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
+#define MXSFB_SYNC_DOTCLK_FAILING_ACT	(1 << 7) /* failing/negtive edge sam=
pling */
=20
 struct mxsfb_platform_data {
 	struct fb_videomode *mode_list;
@@ -44,6 +44,9 @@ struct mxsfb_platform_data {
 				 * allocated. If specified,fb_size must also be specified.
 				 * fb_phys must be unused by Linux.
 				 */
+	u32 sync;		/* sync mask, contains MXSFB specifics not
+				 * carried in fb_info->var.sync
+				 */
 };
=20
 #endif /* __LINUX_MXSFB_H */
--=20
1.7.10.4

