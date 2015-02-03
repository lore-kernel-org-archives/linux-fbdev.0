From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 03 Feb 2015 14:54:27 +0000
Subject: [PATCH 2/2] staging: sm7xxfb: fix remaining CamelCase
Message-Id: <1422975214-15250-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422975214-15250-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1422975214-15250-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

since mixed case names are not encouraged in coding, so those has
been changed to their corresponding lowercase version.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xx.h   | 30 ++++++++++++-------------
 drivers/staging/sm7xxfb/sm7xxfb.c | 46 +++++++++++++++++++--------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
index fe63cd7..c46e8ca 100644
--- a/drivers/staging/sm7xxfb/sm7xx.h
+++ b/drivers/staging/sm7xxfb/sm7xx.h
@@ -99,27 +99,27 @@ static inline unsigned int smtc_seqr(int reg)
  */
 
 struct ModeInit {
-	int mmSizeX;
-	int mmSizeY;
+	int mmsizex;
+	int mmsizey;
 	int bpp;
 	int hz;
-	unsigned char Init_MISC;
-	unsigned char Init_SR00_SR04[SIZE_SR00_SR04];
-	unsigned char Init_SR10_SR24[SIZE_SR10_SR24];
-	unsigned char Init_SR30_SR75[SIZE_SR30_SR75];
-	unsigned char Init_SR80_SR93[SIZE_SR80_SR93];
-	unsigned char Init_SRA0_SRAF[SIZE_SRA0_SRAF];
-	unsigned char Init_GR00_GR08[SIZE_GR00_GR08];
-	unsigned char Init_AR00_AR14[SIZE_AR00_AR14];
-	unsigned char Init_CR00_CR18[SIZE_CR00_CR18];
-	unsigned char Init_CR30_CR4D[SIZE_CR30_CR4D];
-	unsigned char Init_CR90_CRA7[SIZE_CR90_CRA7];
+	unsigned char init_misc;
+	unsigned char init_sr00_sr04[SIZE_SR00_SR04];
+	unsigned char init_sr10_sr24[SIZE_SR10_SR24];
+	unsigned char init_sr30_sr75[SIZE_SR30_SR75];
+	unsigned char init_sr80_sr93[SIZE_SR80_SR93];
+	unsigned char init_sra0_sraf[SIZE_SRA0_SRAF];
+	unsigned char init_gr00_gr08[SIZE_GR00_GR08];
+	unsigned char init_ar00_ar14[SIZE_AR00_AR14];
+	unsigned char init_cr00_cr18[SIZE_CR00_CR18];
+	unsigned char init_cr30_cr4d[SIZE_CR30_CR4D];
+	unsigned char init_cr90_cra7[SIZE_CR90_CRA7];
 };
 
 /**********************************************************************
 			 SM712 Mode table.
  **********************************************************************/
-struct ModeInit VGAMode[] = {
+struct ModeInit vgamode[] = {
 	{
 	 /*  mode#0: 640 x 480  16Bpp  60Hz */
 	 640, 480, 16, 60,
@@ -776,4 +776,4 @@ struct ModeInit VGAMode[] = {
 	 },
 };
 
-#define numVGAModes		ARRAY_SIZE(VGAMode)
+#define numvgamodes		ARRAY_SIZE(vgamode)
diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 3150f0b..4cab961 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -470,38 +470,38 @@ smtcfb_write(struct fb_info *info, const char __user *buf, size_t count,
 static void sm7xx_set_timing(struct smtcfb_info *sfb)
 {
 	int i = 0, j = 0;
-	u32 m_nScreenStride;
+	u32 m_nscreenstride;
 
 	dev_dbg(&sfb->pdev->dev,
 		"sfb->width=%d sfb->height=%d sfb->fb.var.bits_per_pixel=%d sfb->hz=%d\n",
 		sfb->width, sfb->height, sfb->fb.var.bits_per_pixel, sfb->hz);
 
-	for (j = 0; j < numVGAModes; j++) {
-		if (VGAMode[j].mmSizeX = sfb->width &&
-		    VGAMode[j].mmSizeY = sfb->height &&
-		    VGAMode[j].bpp = sfb->fb.var.bits_per_pixel &&
-		    VGAMode[j].hz = sfb->hz) {
+	for (j = 0; j < numvgamodes; j++) {
+		if (vgamode[j].mmsizex = sfb->width &&
+		    vgamode[j].mmsizey = sfb->height &&
+		    vgamode[j].bpp = sfb->fb.var.bits_per_pixel &&
+		    vgamode[j].hz = sfb->hz) {
 			dev_dbg(&sfb->pdev->dev,
-				"VGAMode[j].mmSizeX=%d VGAMode[j].mmSizeY=%d VGAMode[j].bpp=%d VGAMode[j].hz=%d\n",
-				VGAMode[j].mmSizeX, VGAMode[j].mmSizeY,
-				VGAMode[j].bpp, VGAMode[j].hz);
+				"vgamode[j].mmsizex=%d vgamode[j].mmSizeY=%d vgamode[j].bpp=%d vgamode[j].hz=%d\n",
+				vgamode[j].mmsizex, vgamode[j].mmsizey,
+				vgamode[j].bpp, vgamode[j].hz);
 
-			dev_dbg(&sfb->pdev->dev, "VGAMode index=%d\n", j);
+			dev_dbg(&sfb->pdev->dev, "vgamode index=%d\n", j);
 
 			smtc_mmiowb(0x0, 0x3c6);
 
 			smtc_seqw(0, 0x1);
 
-			smtc_mmiowb(VGAMode[j].Init_MISC, 0x3c2);
+			smtc_mmiowb(vgamode[j].init_misc, 0x3c2);
 
 			/* init SEQ register SR00 - SR04 */
 			for (i = 0; i < SIZE_SR00_SR04; i++)
-				smtc_seqw(i, VGAMode[j].Init_SR00_SR04[i]);
+				smtc_seqw(i, vgamode[j].init_sr00_sr04[i]);
 
 			/* init SEQ register SR10 - SR24 */
 			for (i = 0; i < SIZE_SR10_SR24; i++)
 				smtc_seqw(i + 0x10,
-					  VGAMode[j].Init_SR10_SR24[i]);
+					  vgamode[j].init_sr10_sr24[i]);
 
 			/* init SEQ register SR30 - SR75 */
 			for (i = 0; i < SIZE_SR30_SR75; i++)
@@ -509,39 +509,39 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 				    (i + 0x30) != 0x6a &&
 				    (i + 0x30) != 0x6b)
 					smtc_seqw(i + 0x30,
-						  VGAMode[j].Init_SR30_SR75[i]);
+						  vgamode[j].init_sr30_sr75[i]);
 
 			/* init SEQ register SR80 - SR93 */
 			for (i = 0; i < SIZE_SR80_SR93; i++)
 				smtc_seqw(i + 0x80,
-					  VGAMode[j].Init_SR80_SR93[i]);
+					  vgamode[j].init_sr80_sr93[i]);
 
 			/* init SEQ register SRA0 - SRAF */
 			for (i = 0; i < SIZE_SRA0_SRAF; i++)
 				smtc_seqw(i + 0xa0,
-					  VGAMode[j].Init_SRA0_SRAF[i]);
+					  vgamode[j].init_sra0_sraf[i]);
 
 			/* init Graphic register GR00 - GR08 */
 			for (i = 0; i < SIZE_GR00_GR08; i++)
-				smtc_grphw(i, VGAMode[j].Init_GR00_GR08[i]);
+				smtc_grphw(i, vgamode[j].init_gr00_gr08[i]);
 
 			/* init Attribute register AR00 - AR14 */
 			for (i = 0; i < SIZE_AR00_AR14; i++)
-				smtc_attrw(i, VGAMode[j].Init_AR00_AR14[i]);
+				smtc_attrw(i, vgamode[j].init_ar00_ar14[i]);
 
 			/* init CRTC register CR00 - CR18 */
 			for (i = 0; i < SIZE_CR00_CR18; i++)
-				smtc_crtcw(i, VGAMode[j].Init_CR00_CR18[i]);
+				smtc_crtcw(i, vgamode[j].init_cr00_cr18[i]);
 
 			/* init CRTC register CR30 - CR4D */
 			for (i = 0; i < SIZE_CR30_CR4D; i++)
 				smtc_crtcw(i + 0x30,
-					   VGAMode[j].Init_CR30_CR4D[i]);
+					   vgamode[j].init_cr30_cr4d[i]);
 
 			/* init CRTC register CR90 - CRA7 */
 			for (i = 0; i < SIZE_CR90_CRA7; i++)
 				smtc_crtcw(i + 0x90,
-					   VGAMode[j].Init_CR90_CRA7[i]);
+					   vgamode[j].init_cr90_cra7[i]);
 		}
 	}
 	smtc_mmiowb(0x67, 0x3c2);
@@ -551,7 +551,7 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 	writel(0x0, sfb->vp_regs + 0x40);
 
 	/* set data width */
-	m_nScreenStride +	m_nscreenstride  		(sfb->width * sfb->fb.var.bits_per_pixel) / 64;
 	switch (sfb->fb.var.bits_per_pixel) {
 	case 8:
@@ -567,7 +567,7 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 		writel(0x00030000, sfb->vp_regs + 0x0);
 		break;
 	}
-	writel((u32) (((m_nScreenStride + 2) << 16) | m_nScreenStride),
+	writel((u32) (((m_nscreenstride + 2) << 16) | m_nscreenstride),
 	       sfb->vp_regs + 0x10);
 }
 
-- 
1.8.1.2

