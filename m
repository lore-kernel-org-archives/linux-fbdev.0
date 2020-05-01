From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 01 May 2020 21:50:38 +0000
Subject: [PATCH] video/fbdev/matroxfb: Remove dead code
Message-Id: <1588370291-7746-1-git-send-email-jrdr.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tglx@linutronix.de, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Souptick Joarder <jrdr.linux@gmail.com>

These are dead code since 3.15. If there is no plan to use it further
it can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/matrox/matroxfb_DAC1064.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
index 765e805..9c2a2c0 100644
--- a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
+++ b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
@@ -603,9 +603,6 @@ static void MGA1064_ramdac_init(struct matrox_fb_info *minfo)
 /* BIOS environ */
 static int x7AF4 = 0x10;	/* flags, maybe 0x10 = SDRAM, 0x00 = SGRAM??? */
 				/* G100 wants 0x10, G200 SGRAM does not care... */
-#if 0
-static int def50 = 0;	/* reg50, & 0x0F, & 0x3000 (only 0x0000, 0x1000, 0x2000 (0x3000 disallowed and treated as 0) */
-#endif
 
 static void MGAG100_progPixClock(const struct matrox_fb_info *minfo, int flags,
 				 int m, int n, int p)
@@ -843,9 +840,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
 	struct matrox_hw_state *hw = &minfo->hw;
 
         u_int32_t reg50;
-#if 0
-	u_int32_t q;
-#endif
 
 	DBG(__func__)
 
@@ -927,11 +921,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
 		mga_writeb(minfo->video.vbase, 0x0000, 0xAA);
 		mga_writeb(minfo->video.vbase, 0x0800, 0x55);
 		mga_writeb(minfo->video.vbase, 0x4000, 0x55);
-#if 0
-		if (mga_readb(minfo->video.vbase, 0x0000) != 0xAA) {
-			hw->MXoptionReg &= ~0x1000;
-		}
-#endif
 		hw->MXoptionReg |= 0x00078020;
 	} else if (minfo->devflags.accelerator = FB_ACCEL_MATROX_MGAG200) {
 		pci_read_config_dword(minfo->pcidev, PCI_OPTION2_REG, &reg50);
-- 
1.9.1
