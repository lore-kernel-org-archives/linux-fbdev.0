From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 15 Jul 2015 04:14:47 +0000
Subject: [PATCH v5 18/19] staging: sm750fb: remove unnecessary braces
Message-Id: <1436933688-5408-18-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
In-Reply-To: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl warning:
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 9 +++------
 drivers/staging/sm750fb/sm750_hw.c    | 6 ++----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 23be0f7..0f563a9 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -259,9 +259,8 @@ unsigned int rop2)   /* ROP value */
 	FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/Bpp)) |
 	FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (sPitch/Bpp))); /* dpr3c */
 
-	if (accel->de_wait() != 0) {
+	if (accel->de_wait() != 0)
 		return -1;
-	}
 
 	{
 
@@ -332,9 +331,8 @@ int hw_imageblit(struct lynx_accel *accel,
 	ul4BytesPerScan = ulBytesPerScan & ~3;
 	ulBytesRemain = ulBytesPerScan & 3;
 
-	if (accel->de_wait() != 0) {
+	if (accel->de_wait() != 0)
 		return -1;
-	}
 
 	/* 2D Source Base.
 	 Use 0 for HOST Blt.
@@ -402,9 +400,8 @@ int hw_imageblit(struct lynx_accel *accel,
 	/* Write MONO data (line by line) to 2D Engine data port */
 	for (i = 0; i < height; i++) {
 		/* For each line, send the data in chunks of 4 bytes */
-		for (j = 0; j < (ul4BytesPerScan/4); j++) {
+		for (j = 0; j < (ul4BytesPerScan/4); j++)
 			write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
-		}
 
 		if (ulBytesRemain) {
 			memcpy(ajRemain, pSrcbuf+ul4BytesPerScan, ulBytesRemain);
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index fb9c631..d1d6ae7 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -188,9 +188,8 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	}
 
 	/* init 2d engine */
-	if (!share->accel_off) {
+	if (!share->accel_off)
 		hw_sm750_initAccel(share);
-	}
 
 	return 0;
 }
@@ -537,9 +536,8 @@ int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
 
-	if (output->paths & sm750_panel) {
+	if (output->paths & sm750_panel)
 		POKE32(PANEL_DISPLAY_CTRL, FIELD_VALUE(PEEK32(PANEL_DISPLAY_CTRL), PANEL_DISPLAY_CTRL, DATA, pps));
-	}
 
 	return 0;
 }
-- 
2.4.5

