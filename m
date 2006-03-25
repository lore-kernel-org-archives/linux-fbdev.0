From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] video/sis/init301.c:SiS_ChrontelDoSomething2(): remove dead code
Date: Sat, 25 Mar 2006 20:47:29 +0100
Message-ID: <20060325194729.GR4053@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751105AbWCYTrc@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: thomas@winischhofer.net, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

The Coverity checker spotted these two unused variables.

Please check whether this patch is correct or whether they should be 
used.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Mar 2006

 drivers/video/sis/init301.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- linux-2.6.16-rc5-mm3-full/drivers/video/sis/init301.c.old	2006-03-09 23:39:56.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/video/sis/init301.c	2006-03-09 23:40:48.000000000 +0100
@@ -8560,39 +8560,30 @@
 
      }
 }
 
 static void
 SiS_ChrontelDoSomething2(struct SiS_Private *SiS_Pr)
 {
-     unsigned short temp,tempcl,tempch;
+     unsigned short temp;
 
      SiS_LongDelay(SiS_Pr, 1);
-     tempcl = 3;
-     tempch = 0;
 
      do {
        temp = SiS_GetCH701x(SiS_Pr,0x66);
        temp &= 0x04;  /* PLL stable? -> bail out */
        if(temp == 0x04) break;
 
        if(SiS_Pr->ChipType == SIS_740) {
           /* Power down LVDS output, PLL normal operation */
           SiS_SetCH701x(SiS_Pr,0x76,0xac);
        }
 
        SiS_SetCH701xForLCD(SiS_Pr);
 
-       if(tempcl == 0) {
-           if(tempch == 3) break;
-	   SiS_ChrontelResetDB(SiS_Pr);
-	   tempcl = 3;
-	   tempch++;
-       }
-       tempcl--;
        temp = SiS_GetCH701x(SiS_Pr,0x76);
        temp &= 0xfb;  /* Reset PLL */
        SiS_SetCH701x(SiS_Pr,0x76,temp);
        SiS_LongDelay(SiS_Pr, 2);
        temp = SiS_GetCH701x(SiS_Pr,0x76);
        temp |= 0x04;  /* PLL normal operation */
        SiS_SetCH701x(SiS_Pr,0x76,temp);
