From: =?utf-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Date: Fri, 25 Jun 2010 07:53:20 +0000
Subject: [PATCH] imxfb: add the possibility to control PWMR
Message-Id: <1277452400-6032-1-git-send-email-eric@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

this adds the possibility to enable/disable the backlight through
the PWMR register, as offered in mx3fb.

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 arch/arm/plat-mxc/include/mach/imxfb.h |    1 +
 drivers/video/imxfb.c                  |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/imxfb.h b/arch/arm/plat-mxc/inc=
lude/mach/imxfb.h
index 5263506..3c24778 100644
--- a/arch/arm/plat-mxc/include/mach/imxfb.h
+++ b/arch/arm/plat-mxc/include/mach/imxfb.h
@@ -67,6 +67,7 @@ struct imx_fb_platform_data {
 	u_int		pwmr;
 	u_int		lscr1;
 	u_int		dmacr;
+	u_int		backlight_level;
=20
 	u_char * fixed_screen_cpu;
 	dma_addr_t fixed_screen_dma;
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index b4b6dec..9451200 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -169,6 +169,7 @@ struct imxfb_info {
 	u_int			pwmr;
 	u_int			lscr1;
 	u_int			dmacr;
+	u_int			backlight_level;
 	u_int			cmap_inverse:1,
 				cmap_static:1,
 				unused:30;
@@ -302,6 +303,14 @@ static int imxfb_setcolreg(u_int regno, u_int red, u_i=
nt green, u_int blue,
 	return ret;
 }
=20
+static void imx_fb_set_brightness(struct imxfb_info *fbi, uint8_t value)
+{
+	pr_debug("%s: value =3D %d\n", __func__, value);
+	/* This might be board-specific */
+	writel((fbi->pwmr & ~0xFF) | value, fbi->regs + LCDC_PWMR);
+	return;
+}
+
 static const struct imx_fb_videomode *imxfb_find_mode(struct imxfb_info *f=
bi)
 {
 	struct imx_fb_videomode *m;
@@ -470,12 +479,16 @@ static void imxfb_enable_controller(struct imxfb_info=
 *fbi)
 		fbi->backlight_power(1);
 	if (fbi->lcd_power)
 		fbi->lcd_power(1);
+	if (fbi->backlight_level)
+		imx_fb_set_brightness(fbi, fbi->backlight_level);
 }
=20
 static void imxfb_disable_controller(struct imxfb_info *fbi)
 {
 	pr_debug("Disabling LCD controller\n");
=20
+	if (fbi->backlight_level)
+		imx_fb_set_brightness(fbi, 0);
 	if (fbi->backlight_power)
 		fbi->backlight_power(0);
 	if (fbi->lcd_power)
@@ -660,6 +673,7 @@ static int __init imxfb_init_fbinfo(struct platform_dev=
ice *pdev)
 	fbi->pwmr			=3D pdata->pwmr;
 	fbi->lcd_power			=3D pdata->lcd_power;
 	fbi->backlight_power		=3D pdata->backlight_power;
+	fbi->backlight_level		=3D pdata->backlight_level;
=20
 	for (i =3D 0, m =3D &pdata->mode[0]; i < pdata->num_modes; i++, m++)
 		info->fix.smem_len =3D max_t(size_t, info->fix.smem_len,
--=20
1.6.3.3

