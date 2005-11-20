From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] video/matrox/matroxfb_misc.c: remove dead code
Date: Mon, 21 Nov 2005 00:15:34 +0100
Message-ID: <20051120231534.GG16060@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932111AbVKTXPg@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, linux-kernel@vger.kernel.org

The Coverity checker spotted this dead code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/matrox/matroxfb_misc.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/video/matrox/matroxfb_misc.c.old	2005-11-20 22:27:01.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/video/matrox/matroxfb_misc.c	2005-11-20 22:27:21.000000000 +0100
@@ -192,11 +192,8 @@
 	unsigned int wd;
 	unsigned int divider;
 	int i;
-	int fwidth;
 	struct matrox_hw_state * const hw = &ACCESS_FBINFO(hw);
 
-	fwidth = 8;
-
 	DBG(__FUNCTION__)
 
 	hw->SEQ[0] = 0x00;
@@ -235,10 +232,7 @@
 	hw->ATTR[16] = 0x41;
 	hw->ATTR[17] = 0xFF;
 	hw->ATTR[18] = 0x0F;
-	if (fwidth == 9)
-		hw->ATTR[19] = 0x08;
-	else
-		hw->ATTR[19] = 0x00;
+	hw->ATTR[19] = 0x00;
 	hw->ATTR[20] = 0x00;
 
 	hd = m->HDisplay >> 3;
