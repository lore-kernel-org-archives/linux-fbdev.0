From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 13 May 2011 15:54:46 +0000
Subject: [PATCH 2/5] video: mb862xxfb: use pre-initialized configuration for PCI GDCs
Message-Id: <1305302089-7666-3-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If the bootloader has already initialized the display
controller, do not re-initialize it in the driver. Take over
the bootloader's configuration instead. This is already supported
for non PCI GDCs Lime and Mint. Add this functionality for PCI
GDCs Coral-P and Coral-PA. It is useful to avoid flicker and
also avoids unneeded init delays while booting.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mb862xx/mb862xxfb.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/video/mb862xx/mb862xxfb.c b/drivers/video/mb862xx/mb862xxfb.c
index 8257958..a1b81e7 100644
--- a/drivers/video/mb862xx/mb862xxfb.c
+++ b/drivers/video/mb862xx/mb862xxfb.c
@@ -746,13 +746,21 @@ static int coralp_init(struct mb862xxfb_par *par)
 	cn = (ver & GC_CID_CNAME_MSK) >> 8;
 	ver = ver & GC_CID_VERSION_MSK;
 	if (cn = 3) {
+		unsigned long reg;
+
 		dev_info(par->dev, "Fujitsu Coral-%s GDC Rev.%d found\n",\
 			 (ver = 6) ? "P" : (ver = 8) ? "PA" : "?",
 			 par->pdev->revision);
-		outreg(host, GC_CCF, GC_CCF_CGE_166 | GC_CCF_COT_133);
-		udelay(200);
-		outreg(host, GC_MMR, GC_MMR_CORALP_EVB_VAL);
-		udelay(10);
+		reg = inreg(disp, GC_DCM1);
+		if (reg & GC_DCM01_DEN && reg & GC_DCM01_L0E)
+			par->pre_init = 1;
+
+		if (!par->pre_init) {
+			outreg(host, GC_CCF, GC_CCF_CGE_166 | GC_CCF_COT_133);
+			udelay(200);
+			outreg(host, GC_MMR, GC_MMR_CORALP_EVB_VAL);
+			udelay(10);
+		}
 		/* Clear interrupt status */
 		outreg(host, GC_IST, 0);
 	} else {
-- 
1.7.1

