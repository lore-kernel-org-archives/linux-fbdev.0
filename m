From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] video/sis/init301.c:SiS_ChrontelDoSomething2(): remove dead code
Date: Fri, 10 Mar 2006 00:06:57 +0100
Message-ID: <20060309230657.GL21864@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHUEX-0000uX-0U
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Mar 2006 15:07:49 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FHUEW-0004yN-F0
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Mar 2006 15:07:49 -0800
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas@winischhofer.net
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

The Coverity checker spotted these two unused variables.

Please check whether this patch is correct or whether they should be 
used.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

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



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
