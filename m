From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Wed, 04 Feb 2015 11:36:14 +0000
Subject: [PATCH RFC] video: fbdev: sis: condition with no effect
Message-Id: <1423049774-16305-1-git-send-email-hofrat@osadl.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>

The if and the else branch code are identical - so the condition has no
effect on the effective code - this patch removes the condition and the
duplicated code.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

This code has been in here since commit 544393fe584d ("sisfb update") so I guess it is
safe to simply remove the duplicated code if nobody noticed for 10 years.

Note that the code is not really CodingStyle compliant - the lines inserted were formatted
to satisfy the coding style but I'm unsure if it is not better to leave it in the
old format.

Patch was only compile tested with x86_64_defconfig +
CONFIG_FB_SIS=m, CONFIG_FB_SIS_300=y, CONFIG_FB_SIS_315=y

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/video/fbdev/sis/init301.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
index 295e0de..9533a8ab 100644
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -7971,13 +7971,8 @@ SiS_SetCHTVReg(struct SiS_Private *SiS_Pr, unsigned short ModeNo, unsigned short
          }
       } else {						/* ---- PAL ---- */
          /* We don't play around with FSCI in PAL mode */
-         if(resindex = 0x04) {
-            SiS_SetCH70xxANDOR(SiS_Pr,0x20,0x00,0xEF);	/* loop filter off */
-            SiS_SetCH70xxANDOR(SiS_Pr,0x21,0x01,0xFE);	/* ACIV on */
-         } else {
-            SiS_SetCH70xxANDOR(SiS_Pr,0x20,0x00,0xEF);	/* loop filter off */
-            SiS_SetCH70xxANDOR(SiS_Pr,0x21,0x01,0xFE);	/* ACIV on */
-         }
+	  SiS_SetCH70xxANDOR(SiS_Pr, 0x20, 0x00, 0xEF);	/* loop filter off */
+	  SiS_SetCH70xxANDOR(SiS_Pr, 0x21, 0x01, 0xFE);	/* ACIV on */
       }
 
 #endif  /* 300 */
-- 
1.7.10.4

