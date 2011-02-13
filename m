From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 13 Feb 2011 22:11:24 +0000
Subject: [PATCH 2/6] sisfb: move XGI POST RAM type detection into a subroutine
Message-Id: <1297635088-13224-3-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297635088-13224-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1297635088-13224-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Winischhofer <thomas@winischhofer.net>

Move XGI POST RAM type detection into a separate subroutine to make
further code changes easier. No changes in functionality

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/sis_main.c |   57 +++++++++++++++++++++++++----------------
 1 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 2c5de66..364559b 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -4936,6 +4936,40 @@ sisfb_post_xgi_setclocks(struct sis_video_info *ivideo, u8 regb)
 	sisfb_post_xgi_delay(ivideo, 0x43);
 }
 
+static u8 __devinit
+sisfb_post_xgi_ramtype(struct sis_video_info *ivideo)
+{
+	unsigned char *bios = ivideo->bios_abase;
+	u8 ramtype;
+	u8 reg;
+	u8 v1;
+
+	ramtype = 0x00; v1 = 0x10;
+	if (ivideo->haveXGIROM) {
+		ramtype = bios[0x62];
+		v1 = bios[0x1d2];
+	}
+	if (!(ramtype & 0x80)) {
+		if (ivideo->chip = XGI_20) {
+			SiS_SetReg(SISCR, 0x97, v1);
+			reg = SiS_GetReg(SISCR, 0x97);
+			if (reg & 0x10) {
+				ramtype = (reg & 0x01) << 1;
+			}
+		} else {
+			reg = SiS_GetReg(SISSR, 0x39);
+			ramtype = reg & 0x02;
+			if (!(ramtype)) {
+				reg = SiS_GetReg(SISSR, 0x3a);
+				ramtype = (reg >> 1) & 0x01;
+			}
+		}
+	}
+	ramtype &= 0x07;
+
+	return ramtype;
+}
+
 static int __devinit
 sisfb_post_xgi(struct pci_dev *pdev)
 {
@@ -5380,28 +5414,7 @@ sisfb_post_xgi(struct pci_dev *pdev)
 		SiS_SetReg(SISSR, 0x1c, 0x00);
 	}
 
-	ramtype = 0x00; v1 = 0x10;
-	if(ivideo->haveXGIROM) {
-		ramtype = bios[0x62];
-		v1 = bios[0x1d2];
-	}
-	if(!(ramtype & 0x80)) {
-		if(ivideo->chip = XGI_20) {
-			SiS_SetReg(SISCR, 0x97, v1);
-			reg = SiS_GetReg(SISCR, 0x97);
-			if(reg & 0x10) {
-				ramtype = (reg & 0x01) << 1;
-			}
-		} else {
-			reg = SiS_GetReg(SISSR, 0x39);
-			ramtype = reg & 0x02;
-			if(!(ramtype)) {
-				reg = SiS_GetReg(SISSR, 0x3a);
-				ramtype = (reg >> 1) & 0x01;
-			}
-		}
-	}
-	ramtype &= 0x07;
+	ramtype = sisfb_post_xgi_ramtype(ivideo);
 
 	regb = 0;	/* ! */
 
-- 
1.5.6.5

