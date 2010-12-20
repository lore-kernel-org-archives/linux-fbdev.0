From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 20 Dec 2010 21:50:22 +0000
Subject: [PATCH 13/13] sisfb: eliminate compiler warnings
Message-Id: <1292881822-32630-14-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292881822-32630-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1292881822-32630-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, thomas@winischhofer.net
Cc: aaro.koskinen@iki.fi

Convert some bit masks to 8-bit values to avoid the following compiler
warnings:

drivers/video/sis/sis_main.c:3858: warning: large integer implicitly truncated to unsigned type
drivers/video/sis/init301.c:5855: warning: large integer implicitly truncated to unsigned type
drivers/video/sis/init301.c:5869: warning: large integer implicitly truncated to unsigned type

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/init301.c  |    4 ++--
 drivers/video/sis/sis_main.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/sis/init301.c b/drivers/video/sis/init301.c
index e24c5ca..a89e3ca 100644
--- a/drivers/video/sis/init301.c
+++ b/drivers/video/sis/init301.c
@@ -5852,7 +5852,7 @@ SiS_SetGroup1_LVDS(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned s
      temp = tempax & 0x00FF;
      SiS_SetReg(SiS_Pr->SiS_Part1Port,0x43,temp);
      temp = ((tempax & 0xFF00) >> 8) << 3;
-     SiS_SetRegANDOR(SiS_Pr->SiS_Part1Port,0x44,~0x0F8,temp);
+     SiS_SetRegANDOR(SiS_Pr->SiS_Part1Port, 0x44, 0x07, temp);
 
      tempax = SiS_Pr->SiS_VDE;				 	/* BDxWadrst1 = BDxWadrst0 + BDxWadroff * VDE */
      if(SiS_Pr->SiS_LCDResInfo = Panel_320x240_1 ||
@@ -5866,7 +5866,7 @@ SiS_SetGroup1_LVDS(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned s
      temp = ((tempeax & 0xFF0000) >> 16) | 0x10;
      SiS_SetReg(SiS_Pr->SiS_Part1Port,0x40,temp);
      temp = ((tempeax & 0x01000000) >> 24) << 7;
-     SiS_SetRegANDOR(SiS_Pr->SiS_Part1Port,0x3C,~0x080,temp);
+     SiS_SetRegANDOR(SiS_Pr->SiS_Part1Port, 0x3C, 0x7F, temp);
 
      SiS_SetReg(SiS_Pr->SiS_Part1Port,0x2F,0x03);
      SiS_SetReg(SiS_Pr->SiS_Part1Port,0x03,0x50);
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 793216b..2fb8c5a 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -3855,7 +3855,7 @@ sisfb_post_setmode(struct sis_video_info *ivideo)
 			reg1 = 0x00;
 		}
 		SiS_SetRegANDOR(SISCR, ivideo->SiS_Pr.SiS_MyCR63, ~0x40, reg);
-		SiS_SetRegANDOR(SISSR, 0x1f, ~0xc0, reg1);
+		SiS_SetRegANDOR(SISSR, 0x1f, 0x3f, reg1);
 	}
 #endif
 
-- 
1.5.6.5

