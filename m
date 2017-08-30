From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 30 Aug 2017 13:19:42 +0000
Subject: [PATCH] video: fbdev: sis: fix duplicated code for different branches
Message-Id: <20170830131942.GA8173@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Refactor code in order to avoid identical code for different branches.

This issue was detected with the help of Coccinelle.

Addresses-Coverity-ID: 1226761
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
This issue was reported by Coverity and it was tested by compilation only.
Please, verify if any of these issues should be addressed differently.
Also, notice that this code has been there since 2005.

 drivers/video/fbdev/sis/init301.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
index 20f7234..99d5a25 100644
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -6848,8 +6848,6 @@ SiS_SetGroup2(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned short
 	   if(SiS_Pr->SiS_VGAHDE >= 1280) {
               tempch = 20;
               tempbx &= ~0x20;
-           } else if(SiS_Pr->SiS_VGAHDE >= 1024) {
-              tempch = 25;
            } else {
 	      tempch = 25; /* OK */
 	   }
@@ -7964,14 +7962,9 @@ SiS_SetCHTVReg(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned short
             }
          }
       } else {						/* ---- PAL ---- */
-         /* We don't play around with FSCI in PAL mode */
-         if(resindex = 0x04) {
-            SiS_SetCH70xxANDOR(SiS_Pr,0x20,0x00,0xEF);	/* loop filter off */
-            SiS_SetCH70xxANDOR(SiS_Pr,0x21,0x01,0xFE);	/* ACIV on */
-         } else {
-            SiS_SetCH70xxANDOR(SiS_Pr,0x20,0x00,0xEF);	/* loop filter off */
-            SiS_SetCH70xxANDOR(SiS_Pr,0x21,0x01,0xFE);	/* ACIV on */
-         }
+	/* We don't play around with FSCI in PAL mode */
+	SiS_SetCH70xxANDOR(SiS_Pr, 0x20, 0x00, 0xEF);	/* loop filter off */
+	SiS_SetCH70xxANDOR(SiS_Pr, 0x21, 0x01, 0xFE);	/* ACIV on */
       }
 
 #endif  /* 300 */
@@ -9657,8 +9650,6 @@ SetDelayComp(struct SiS_Private *SiS_Pr, unsigned short ModeNo)
 	      delay = 0x0a;
 	   } else if(IS_SIS740) {
 	      delay = 0x00;
-	   } else if(SiS_Pr->ChipType < SIS_330) {
-	      delay = 0x0c;
 	   } else {
 	      delay = 0x0c;
 	   }
-- 
2.5.0

