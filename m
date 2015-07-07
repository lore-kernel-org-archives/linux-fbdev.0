From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 07 Jul 2015 08:26:33 +0000
Subject: [PATCH 1/5] staging: sm7xxfb: remove unused macros
Message-Id: <1436256877-10754-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Dan Carpenter <dan.carpenter@oracle.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

These macros were only defined but not used anywhere.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xx.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
index 4bed094..31a21bd 100644
--- a/drivers/staging/sm7xxfb/sm7xx.h
+++ b/drivers/staging/sm7xxfb/sm7xx.h
@@ -13,8 +13,6 @@
  *  more details.
  */
 
-#define NR_PALETTE        256
-
 #define FB_ACCEL_SMI_LYNX 88
 
 #define SCREEN_X_RES      1024
@@ -31,12 +29,8 @@
 
 extern void __iomem *smtc_regbaseaddress;
 #define smtc_mmiowb(dat, reg)	writeb(dat, smtc_regbaseaddress + reg)
-#define smtc_mmioww(dat, reg)	writew(dat, smtc_regbaseaddress + reg)
-#define smtc_mmiowl(dat, reg)	writel(dat, smtc_regbaseaddress + reg)
 
 #define smtc_mmiorb(reg)	readb(smtc_regbaseaddress + reg)
-#define smtc_mmiorw(reg)	readw(smtc_regbaseaddress + reg)
-#define smtc_mmiorl(reg)	readl(smtc_regbaseaddress + reg)
 
 #define SIZE_SR00_SR04      (0x04 - 0x00 + 1)
 #define SIZE_SR10_SR24      (0x24 - 0x10 + 1)
@@ -48,8 +42,6 @@ extern void __iomem *smtc_regbaseaddress;
 #define SIZE_CR00_CR18      (0x18 - 0x00 + 1)
 #define SIZE_CR30_CR4D      (0x4D - 0x30 + 1)
 #define SIZE_CR90_CRA7      (0xA7 - 0x90 + 1)
-#define SIZE_VPR		(0x6C + 1)
-#define SIZE_DPR		(0x44 + 1)
 
 static inline void smtc_crtcw(int reg, int val)
 {
@@ -57,24 +49,12 @@ static inline void smtc_crtcw(int reg, int val)
 	smtc_mmiowb(val, 0x3d5);
 }
 
-static inline unsigned int smtc_crtcr(int reg)
-{
-	smtc_mmiowb(reg, 0x3d4);
-	return smtc_mmiorb(0x3d5);
-}
-
 static inline void smtc_grphw(int reg, int val)
 {
 	smtc_mmiowb(reg, 0x3ce);
 	smtc_mmiowb(val, 0x3cf);
 }
 
-static inline unsigned int smtc_grphr(int reg)
-{
-	smtc_mmiowb(reg, 0x3ce);
-	return smtc_mmiorb(0x3cf);
-}
-
 static inline void smtc_attrw(int reg, int val)
 {
 	smtc_mmiorb(0x3da);
-- 
1.8.1.2

