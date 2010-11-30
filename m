From: Daniel Drake <dsd@laptop.org>
Date: Tue, 30 Nov 2010 20:34:52 +0000
Subject: [PATCH] lxfb: Maintain video processor palette through suspend/resume
Message-Id: <20101130203452.BAC5F9D401B@zog.reactivated.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The Geode X driver uses both of the LX's palettes, one for gamma
correction and one for colormaps.

The kernel driver currently only backs up the one used for colormaps
during suspend/resume. If you mess with gamma settings and do a
suspend/resume, colors go funny.

Fix this by backing up the video proc palette during suspend/resume,
alongside the display controller one which is already handled.

Signed-off-by: Daniel Drake <dsd@laptop.org>
Acked-by: Andres Salomon <dilinger@queued.net>
---
 drivers/video/geode/lxfb.h     |    4 +++-
 drivers/video/geode/lxfb_ops.c |   20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/video/geode/lxfb.h b/drivers/video/geode/lxfb.h
index e4c4d89..be8ccb4 100644
--- a/drivers/video/geode/lxfb.h
+++ b/drivers/video/geode/lxfb.h
@@ -22,6 +22,7 @@
 #define DC_HFILT_COUNT	0x100
 #define DC_VFILT_COUNT	0x100
 #define VP_COEFF_SIZE	0x1000
+#define VP_PAL_COUNT	0x100
 
 #define OUTPUT_CRT   0x01
 #define OUTPUT_PANEL 0x02
@@ -48,7 +49,8 @@ struct lxfb_par {
 	uint64_t vp[VP_REG_COUNT];
 	uint64_t fp[FP_REG_COUNT];
 
-	uint32_t pal[DC_PAL_COUNT];
+	uint32_t dc_pal[DC_PAL_COUNT];
+	uint32_t vp_pal[VP_PAL_COUNT];
 	uint32_t hcoeff[DC_HFILT_COUNT * 2];
 	uint32_t vcoeff[DC_VFILT_COUNT];
 	uint32_t vp_coeff[VP_COEFF_SIZE / 4];
diff --git a/drivers/video/geode/lxfb_ops.c b/drivers/video/geode/lxfb_ops.c
index 85ec7f6..79e9abc 100644
--- a/drivers/video/geode/lxfb_ops.c
+++ b/drivers/video/geode/lxfb_ops.c
@@ -610,10 +610,15 @@ static void lx_save_regs(struct lxfb_par *par)
 	memcpy(par->vp, par->vp_regs, sizeof(par->vp));
 	memcpy(par->fp, par->vp_regs + VP_FP_START, sizeof(par->fp));
 
-	/* save the palette */
+	/* save the display controller palette */
 	write_dc(par, DC_PAL_ADDRESS, 0);
-	for (i = 0; i < ARRAY_SIZE(par->pal); i++)
-		par->pal[i] = read_dc(par, DC_PAL_DATA);
+	for (i = 0; i < ARRAY_SIZE(par->dc_pal); i++)
+		par->dc_pal[i] = read_dc(par, DC_PAL_DATA);
+
+	/* save the video processor palette */
+	write_vp(par, VP_PAR, 0);
+	for (i = 0; i < ARRAY_SIZE(par->vp_pal); i++)
+		par->vp_pal[i] = read_vp(par, VP_PDR);
 
 	/* save the horizontal filter coefficients */
 	filt = par->dc[DC_IRQ_FILT_CTL] | DC_IRQ_FILT_CTL_H_FILT_SEL;
@@ -706,8 +711,8 @@ static void lx_restore_display_ctlr(struct lxfb_par *par)
 
 	/* restore the palette */
 	write_dc(par, DC_PAL_ADDRESS, 0);
-	for (i = 0; i < ARRAY_SIZE(par->pal); i++)
-		write_dc(par, DC_PAL_DATA, par->pal[i]);
+	for (i = 0; i < ARRAY_SIZE(par->dc_pal); i++)
+		write_dc(par, DC_PAL_DATA, par->dc_pal[i]);
 
 	/* restore the horizontal filter coefficients */
 	filt = par->dc[DC_IRQ_FILT_CTL] | DC_IRQ_FILT_CTL_H_FILT_SEL;
@@ -751,6 +756,11 @@ static void lx_restore_video_proc(struct lxfb_par *par)
 		}
 	}
 
+	/* restore video processor palette */
+	write_vp(par, VP_PAR, 0);
+	for (i = 0; i < ARRAY_SIZE(par->vp_pal); i++)
+		write_vp(par, VP_PDR, par->vp_pal[i]);
+
 	/* restore video coeff ram */
 	memcpy(par->vp_regs + VP_VCR, par->vp_coeff, sizeof(par->vp_coeff));
 }
-- 
1.7.3.2

