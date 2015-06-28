From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:43:54 +0000
Subject: [PATCH 01/11] staging: sm750fb: replace spaces with tabs
Message-Id: <1435535044-22042-2-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Replace spaces with tabs according to checkpatch.pl error message:
"ERROR: code indent should use tabs where possible"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 70 +++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 84381bc..3b3089c 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -171,23 +171,23 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 		/* Set up GPIO for software I2C to program DVI chip in the
 		   Xilinx SP605 board, in order to have video signal.
 		 */
-        swI2CInit(0, 1);
+	swI2CInit(0, 1);
 
 
-        /* Customer may NOT use CH7301 DVI chip, which has to be
-           initialized differently.
-         */
-        if (swI2CReadReg(0xec, 0x4a) = 0x95)
-        {
-            /* The following register values for CH7301 are from
-               Chrontel app note and our experiment.
-             */
+	/* Customer may NOT use CH7301 DVI chip, which has to be
+	   initialized differently.
+	*/
+	if (swI2CReadReg(0xec, 0x4a) = 0x95)
+	{
+		/* The following register values for CH7301 are from
+		   Chrontel app note and our experiment.
+		*/
 			pr_info("yes,CH7301 DVI chip found\n");
-            swI2CWriteReg(0xec, 0x1d, 0x16);
-            swI2CWriteReg(0xec, 0x21, 0x9);
-            swI2CWriteReg(0xec, 0x49, 0xC0);
+		swI2CWriteReg(0xec, 0x1d, 0x16);
+		swI2CWriteReg(0xec, 0x21, 0x9);
+		swI2CWriteReg(0xec, 0x49, 0xC0);
 			pr_info("okay,CH7301 DVI chip setup done\n");
-        }
+	}
 	}
 
 	/* init 2d engine */
@@ -612,28 +612,28 @@ int hw_sm750_deWait(void)
 }
 
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
-        const struct fb_var_screeninfo *var,
-        const struct fb_info *info)
+	const struct fb_var_screeninfo *var,
+	const struct fb_info *info)
 {
-    uint32_t total;
-    /* check params */
-    if ((var->xoffset + var->xres > var->xres_virtual) ||
-            (var->yoffset + var->yres > var->yres_virtual)) {
-        return -EINVAL;
-    }
-
-    total = var->yoffset * info->fix.line_length +
-        ((var->xoffset * var->bits_per_pixel) >> 3);
-    total += crtc->oScreen;
-    if (crtc->channel = sm750_primary) {
-        POKE32(PANEL_FB_ADDRESS,
-                FIELD_VALUE(PEEK32(PANEL_FB_ADDRESS),
-                    PANEL_FB_ADDRESS, ADDRESS, total));
-    } else {
-        POKE32(CRT_FB_ADDRESS,
-                FIELD_VALUE(PEEK32(CRT_FB_ADDRESS),
-                    CRT_FB_ADDRESS, ADDRESS, total));
-    }
-    return 0;
+	uint32_t total;
+	/* check params */
+	if ((var->xoffset + var->xres > var->xres_virtual) ||
+	    (var->yoffset + var->yres > var->yres_virtual)) {
+		return -EINVAL;
+	}
+
+	total = var->yoffset * info->fix.line_length +
+		((var->xoffset * var->bits_per_pixel) >> 3);
+	total += crtc->oScreen;
+	if (crtc->channel = sm750_primary) {
+		POKE32(PANEL_FB_ADDRESS,
+			FIELD_VALUE(PEEK32(PANEL_FB_ADDRESS),
+				PANEL_FB_ADDRESS, ADDRESS, total));
+	} else {
+		POKE32(CRT_FB_ADDRESS,
+			FIELD_VALUE(PEEK32(CRT_FB_ADDRESS),
+				CRT_FB_ADDRESS, ADDRESS, total));
+	}
+	return 0;
 }
 
-- 
2.1.0

