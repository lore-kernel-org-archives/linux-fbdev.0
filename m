From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] video/matrox/matroxfb_misc.c: remove dead code
Date: Tue, 13 Dec 2005 03:28:37 +0100
Message-ID: <20051213022837.GA23349@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ElzuG-00040B-9Q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 18:28:44 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1ElzuE-0003i2-7J
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 18:28:44 -0800
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
To: Andrew Morton <akpm@osdl.org>
Cc: vandrove@vc.cvut.cz, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, linux-kernel@vger.kernel.org

The Coverity checker spotted this dead code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Nov 2005

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



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
