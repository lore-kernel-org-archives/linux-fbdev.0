From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/matrox/matroxfb_misc.c: remove dead code
Date: Mon, 2 May 2005 03:47:04 +0200
Message-ID: <20050502014704.GX3592@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSQ2P-0000H6-F9
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 May 2005 18:47:57 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DSQ2O-0005dl-Mk
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 May 2005 18:47:57 -0700
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
Cc: vandrove@vc.cvut.cz, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch removes some obviously dead code found by the Coverity 
checker.

This patch was already ACK'ed by Petr Vandrovec.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Apr 2005

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
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
