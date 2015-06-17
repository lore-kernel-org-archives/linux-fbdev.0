From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 17 Jun 2015 11:36:45 +0000
Subject: [PATCH v2 6/9] staging: sm7xxfb: reduce indention
Message-Id: <1434540288-8289-7-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

reduce code indention keeping the logic same.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 173 ++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 91 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 6bdcd5b..1e60d36 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -255,37 +255,33 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 		/*
 		 * 16/32 bit true-colour, use pseudo-palette for 16 base color
 		 */
-		if (regno < 16) {
-			if (sfb->fb->var.bits_per_pixel = 16) {
-				u32 *pal = sfb->fb->pseudo_palette;
-
-				val = chan_to_field(red, &sfb->fb->var.red);
-				val |= chan_to_field(green,
-						     &sfb->fb->var.green);
-				val |= chan_to_field(blue, &sfb->fb->var.blue);
+		if (regno >= 16)
+			break;
+		if (sfb->fb->var.bits_per_pixel = 16) {
+			u32 *pal = sfb->fb->pseudo_palette;
+
+			val = chan_to_field(red, &sfb->fb->var.red);
+			val |= chan_to_field(green, &sfb->fb->var.green);
+			val |= chan_to_field(blue, &sfb->fb->var.blue);
 #ifdef __BIG_ENDIAN
-				pal[regno] -				    ((red & 0xf800) >> 8) |
-				    ((green & 0xe000) >> 13) |
-				    ((green & 0x1c00) << 3) |
-				    ((blue & 0xf800) >> 3);
+			pal[regno] = ((red & 0xf800) >> 8) |
+				     ((green & 0xe000) >> 13) |
+				     ((green & 0x1c00) << 3) |
+				     ((blue & 0xf800) >> 3);
 #else
-				pal[regno] = val;
+			pal[regno] = val;
 #endif
-			} else {
-				u32 *pal = sfb->fb->pseudo_palette;
+		} else {
+			u32 *pal = sfb->fb->pseudo_palette;
 
-				val = chan_to_field(red, &sfb->fb->var.red);
-				val |= chan_to_field(green,
-						     &sfb->fb->var.green);
-				val |= chan_to_field(blue, &sfb->fb->var.blue);
+			val = chan_to_field(red, &sfb->fb->var.red);
+			val |= chan_to_field(green, &sfb->fb->var.green);
+			val |= chan_to_field(blue, &sfb->fb->var.blue);
 #ifdef __BIG_ENDIAN
-				val -				    (val & 0xff00ff00 >> 8) |
-				    (val & 0x00ff00ff << 8);
+			val = (val & 0xff00ff00 >> 8) |
+			      (val & 0x00ff00ff << 8);
 #endif
-				pal[regno] = val;
-			}
+			pal[regno] = val;
 		}
 		break;
 
@@ -476,72 +472,67 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 		sfb->width, sfb->height, sfb->fb->var.bits_per_pixel, sfb->hz);
 
 	for (j = 0; j < ARRAY_SIZE(vgamode); j++) {
-		if (vgamode[j].mmsizex = sfb->width &&
-		    vgamode[j].mmsizey = sfb->height &&
-		    vgamode[j].bpp = sfb->fb->var.bits_per_pixel &&
-		    vgamode[j].hz = sfb->hz) {
-			dev_dbg(&sfb->pdev->dev,
-				"vgamode[j].mmsizex=%d vgamode[j].mmSizeY=%d vgamode[j].bpp=%d vgamode[j].hz=%d\n",
-				vgamode[j].mmsizex, vgamode[j].mmsizey,
-				vgamode[j].bpp, vgamode[j].hz);
-
-			dev_dbg(&sfb->pdev->dev, "vgamode index=%d\n", j);
-
-			smtc_mmiowb(0x0, 0x3c6);
-
-			smtc_seqw(0, 0x1);
-
-			smtc_mmiowb(vgamode[j].init_misc, 0x3c2);
-
-			/* init SEQ register SR00 - SR04 */
-			for (i = 0; i < SIZE_SR00_SR04; i++)
-				smtc_seqw(i, vgamode[j].init_sr00_sr04[i]);
-
-			/* init SEQ register SR10 - SR24 */
-			for (i = 0; i < SIZE_SR10_SR24; i++)
-				smtc_seqw(i + 0x10,
-					  vgamode[j].init_sr10_sr24[i]);
-
-			/* init SEQ register SR30 - SR75 */
-			for (i = 0; i < SIZE_SR30_SR75; i++)
-				if ((i + 0x30) != 0x62 &&
-				    (i + 0x30) != 0x6a &&
-				    (i + 0x30) != 0x6b)
-					smtc_seqw(i + 0x30,
-						  vgamode[j].init_sr30_sr75[i]);
-
-			/* init SEQ register SR80 - SR93 */
-			for (i = 0; i < SIZE_SR80_SR93; i++)
-				smtc_seqw(i + 0x80,
-					  vgamode[j].init_sr80_sr93[i]);
-
-			/* init SEQ register SRA0 - SRAF */
-			for (i = 0; i < SIZE_SRA0_SRAF; i++)
-				smtc_seqw(i + 0xa0,
-					  vgamode[j].init_sra0_sraf[i]);
-
-			/* init Graphic register GR00 - GR08 */
-			for (i = 0; i < SIZE_GR00_GR08; i++)
-				smtc_grphw(i, vgamode[j].init_gr00_gr08[i]);
-
-			/* init Attribute register AR00 - AR14 */
-			for (i = 0; i < SIZE_AR00_AR14; i++)
-				smtc_attrw(i, vgamode[j].init_ar00_ar14[i]);
-
-			/* init CRTC register CR00 - CR18 */
-			for (i = 0; i < SIZE_CR00_CR18; i++)
-				smtc_crtcw(i, vgamode[j].init_cr00_cr18[i]);
-
-			/* init CRTC register CR30 - CR4D */
-			for (i = 0; i < SIZE_CR30_CR4D; i++)
-				smtc_crtcw(i + 0x30,
-					   vgamode[j].init_cr30_cr4d[i]);
-
-			/* init CRTC register CR90 - CRA7 */
-			for (i = 0; i < SIZE_CR90_CRA7; i++)
-				smtc_crtcw(i + 0x90,
-					   vgamode[j].init_cr90_cra7[i]);
-		}
+		if (vgamode[j].mmsizex != sfb->width ||
+		    vgamode[j].mmsizey != sfb->height ||
+		    vgamode[j].bpp != sfb->fb->var.bits_per_pixel ||
+		    vgamode[j].hz != sfb->hz)
+			continue;
+
+		dev_dbg(&sfb->pdev->dev,
+			"vgamode[j].mmsizex=%d vgamode[j].mmSizeY=%d vgamode[j].bpp=%d vgamode[j].hz=%d\n",
+			vgamode[j].mmsizex, vgamode[j].mmsizey,
+			vgamode[j].bpp, vgamode[j].hz);
+
+		dev_dbg(&sfb->pdev->dev, "vgamode index=%d\n", j);
+
+		smtc_mmiowb(0x0, 0x3c6);
+
+		smtc_seqw(0, 0x1);
+
+		smtc_mmiowb(vgamode[j].init_misc, 0x3c2);
+
+		/* init SEQ register SR00 - SR04 */
+		for (i = 0; i < SIZE_SR00_SR04; i++)
+			smtc_seqw(i, vgamode[j].init_sr00_sr04[i]);
+
+		/* init SEQ register SR10 - SR24 */
+		for (i = 0; i < SIZE_SR10_SR24; i++)
+			smtc_seqw(i + 0x10, vgamode[j].init_sr10_sr24[i]);
+
+		/* init SEQ register SR30 - SR75 */
+		for (i = 0; i < SIZE_SR30_SR75; i++)
+			if ((i + 0x30) != 0x62 && (i + 0x30) != 0x6a &&
+			    (i + 0x30) != 0x6b)
+				smtc_seqw(i + 0x30,
+					  vgamode[j].init_sr30_sr75[i]);
+
+		/* init SEQ register SR80 - SR93 */
+		for (i = 0; i < SIZE_SR80_SR93; i++)
+			smtc_seqw(i + 0x80, vgamode[j].init_sr80_sr93[i]);
+
+		/* init SEQ register SRA0 - SRAF */
+		for (i = 0; i < SIZE_SRA0_SRAF; i++)
+			smtc_seqw(i + 0xa0, vgamode[j].init_sra0_sraf[i]);
+
+		/* init Graphic register GR00 - GR08 */
+		for (i = 0; i < SIZE_GR00_GR08; i++)
+			smtc_grphw(i, vgamode[j].init_gr00_gr08[i]);
+
+		/* init Attribute register AR00 - AR14 */
+		for (i = 0; i < SIZE_AR00_AR14; i++)
+			smtc_attrw(i, vgamode[j].init_ar00_ar14[i]);
+
+		/* init CRTC register CR00 - CR18 */
+		for (i = 0; i < SIZE_CR00_CR18; i++)
+			smtc_crtcw(i, vgamode[j].init_cr00_cr18[i]);
+
+		/* init CRTC register CR30 - CR4D */
+		for (i = 0; i < SIZE_CR30_CR4D; i++)
+			smtc_crtcw(i + 0x30, vgamode[j].init_cr30_cr4d[i]);
+
+		/* init CRTC register CR90 - CRA7 */
+		for (i = 0; i < SIZE_CR90_CRA7; i++)
+			smtc_crtcw(i + 0x90, vgamode[j].init_cr90_cra7[i]);
 	}
 	smtc_mmiowb(0x67, 0x3c2);
 
-- 
1.8.1.2

