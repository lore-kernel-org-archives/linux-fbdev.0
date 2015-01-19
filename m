From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 19 Jan 2015 08:23:05 +0000
Subject: [PATCH v2 6/7] staging: sm7xxfb: remove unnecessary blank lines
Message-Id: <1421655067-7490-6-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421655067-7490-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1421655067-7490-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org

checkpatch cleanup: blank lines are not necessary before closing brace
and after opening brace.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

these are actually two different checkpatch warning, but am sending
them together as they are of similar type.

 drivers/staging/sm7xxfb/sm7xxfb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 6f0469a..097747c 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -298,7 +298,6 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 	}
 
 	return 0;
-
 }
 
 #ifdef __BIG_ENDIAN
@@ -482,7 +481,6 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 		    VGAMode[j].mmSizeY = sfb->height &&
 		    VGAMode[j].bpp = sfb->fb.var.bits_per_pixel &&
 		    VGAMode[j].hz = sfb->hz) {
-
 			dev_dbg(&sfb->pdev->dev,
 				"VGAMode[j].mmSizeX=%d VGAMode[j].mmSizeY=%d VGAMode[j].bpp=%d VGAMode[j].hz=%d\n",
 				VGAMode[j].mmSizeX, VGAMode[j].mmSizeY,
@@ -571,7 +569,6 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 	}
 	writel((u32) (((m_nScreenStride + 2) << 16) | m_nScreenStride),
 	       sfb->vp_regs + 0x10);
-
 }
 
 static void smtc_set_timing(struct smtcfb_info *sfb)
@@ -725,7 +722,6 @@ static void smtc_unmap_mmio(struct smtcfb_info *sfb)
 static int smtc_map_smem(struct smtcfb_info *sfb,
 		struct pci_dev *pdev, u_long smem_len)
 {
-
 	sfb->fb.fix.smem_start = pci_resource_start(pdev, 0);
 
 #ifdef __BIG_ENDIAN
-- 
1.8.1.2

