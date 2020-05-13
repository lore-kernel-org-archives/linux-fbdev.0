From: Oliver Graute <oliver.graute@gmail.com>
Date: Wed, 13 May 2020 14:30:46 +0000
Subject: [PATCH v2] staging: fbtft: fb_st7789v: Initialize the Display
Message-Id: <1589380299-21871-1-git-send-email-oliver.graute@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Oliver Graute <oliver.graute@kococonnector.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, oliver.graute@gmail.com, dan.carpenter@oracle.com

From: Oliver Graute <oliver.graute@kococonnector.com>

Set Gamma Values and Register Values for the HSD20_IPS Panel

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---

need information howto set HSD20_IPS Panel at run time and not at compile time

Changes for v2:
 - added define for HSD20_IPS_GAMMA values
 - check for HSD20_IPS define
 - enabled MIPI_DCS_ENTER_INVERT_MODE

 drivers/staging/fbtft/fb_st7789v.c | 32 +++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 3c3f387936e8..ebc17e05ecd0 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -20,6 +20,12 @@
 	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25\n" \
 	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25"
 
+#define HSD20_IPS_GAMMA \
+	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
+	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
+
+#define HSD20_IPS "true"
+
 /**
  * enum st7789v_command - ST7789V display controller commands
  *
@@ -82,14 +88,20 @@ static int init_display(struct fbtft_par *par)
 
 	/* set pixel format to RGB-565 */
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_16BIT);
+	if (HSD20_IPS)
+		write_reg(par, PORCTRL, 0x05, 0x05, 0x00, 0x33, 0x33);
 
-	write_reg(par, PORCTRL, 0x08, 0x08, 0x00, 0x22, 0x22);
+	else
+		write_reg(par, PORCTRL, 0x08, 0x08, 0x00, 0x22, 0x22);
 
 	/*
 	 * VGH = 13.26V
 	 * VGL = -10.43V
 	 */
-	write_reg(par, GCTRL, 0x35);
+	if (HSD20_IPS)
+		write_reg(par, GCTRL, 0x75);
+	else
+		write_reg(par, GCTRL, 0x35);
 
 	/*
 	 * VDV and VRH register values come from command write
@@ -101,13 +113,19 @@ static int init_display(struct fbtft_par *par)
 	 * VAP =  4.1V + (VCOM + VCOM offset + 0.5 * VDV)
 	 * VAN = -4.1V + (VCOM + VCOM offset + 0.5 * VDV)
 	 */
-	write_reg(par, VRHS, 0x0B);
+	if (HSD20_IPS)
+		write_reg(par, VRHS, 0x13);
+	else
+		write_reg(par, VRHS, 0x0B);
 
 	/* VDV = 0V */
 	write_reg(par, VDVS, 0x20);
 
 	/* VCOM = 0.9V */
-	write_reg(par, VCOMS, 0x20);
+	if (HSD20_IPS)
+		write_reg(par, VCOMS, 0x22);
+	else
+		write_reg(par, VCOMS, 0x20);
 
 	/* VCOM offset = 0V */
 	write_reg(par, VCMOFSET, 0x20);
@@ -120,6 +138,10 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, PWCTRL1, 0xA4, 0xA1);
 
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
+
+	if (HSD20_IPS)
+		write_reg(par, MIPI_DCS_ENTER_INVERT_MODE);
+
 	return 0;
 }
 
@@ -234,7 +256,7 @@ static struct fbtft_display display = {
 	.height = 320,
 	.gamma_num = 2,
 	.gamma_len = 14,
-	.gamma = DEFAULT_GAMMA,
+	.gamma = HSD20_IPS_GAMMA,
 	.fbtftops = {
 		.init_display = init_display,
 		.set_var = set_var,
-- 
2.17.1
