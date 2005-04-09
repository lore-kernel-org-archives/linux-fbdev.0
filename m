From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/matrox/matroxfb_misc.c: remove dead code
Date: Sun, 10 Apr 2005 01:01:56 +0200
Message-ID: <20050409230156.GO3632@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DKOxq-0007U8-DB
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 09 Apr 2005 16:02:06 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DKOxn-0001YY-E7
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 09 Apr 2005 16:02:06 -0700
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
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch removes some obviously dead code found by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm2-full/drivers/video/matrox/matroxfb_misc.c.old	2005-04-09 21:40:17.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/video/matrox/matroxfb_misc.c	2005-04-09 21:40:47.000000000 +0200
@@ -195,14 +195,11 @@ int matroxfb_vgaHWinit(WPMINFO struct my
 	fwidth = 8;
 
 	DBG(__FUNCTION__)
 
 	hw->SEQ[0] = 0x00;
-	if (fwidth == 9)
-		hw->SEQ[1] = 0x00;
-	else
-		hw->SEQ[1] = 0x01;	/* or 0x09 */
+	hw->SEQ[1] = 0x01;	/* or 0x09 */
 	hw->SEQ[2] = 0x0F;	/* bitplanes */
 	hw->SEQ[3] = 0x00;
 	hw->SEQ[4] = 0x0E;
 	/* CRTC 0..7, 9, 16..19, 21, 22 are reprogrammed by Matrox Millennium code... Hope that by MGA1064 too */
 	if (m->dblscan) {



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
