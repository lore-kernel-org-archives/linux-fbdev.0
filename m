From: syrjala@sci.fi
Subject: [PATCH 2/8] atyfb: Fix interlaced modes
Date: Thu, 17 Mar 2005 08:31:04 +0200 (EET)
Message-ID: <20050317063104.1892E7A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBoXD-0006Fo-BX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:07 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBoXB-00049I-N6
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 22:31:07 -0800
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
MIME-Version: 1.0
Content-Type: text; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: alex.kern@gmx.de

Fix interlaced display modes.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 atyfb_base.c |   10 ----------
 1 files changed, 10 deletions(-)

diff -urN linux/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2005-03-16 16:46:41.000000000 +0200
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-16 18:58:33.000000000 +0200
@@ -979,16 +979,6 @@
 		vdisplay = yres;
 		if(vmode & FB_VMODE_DOUBLE)
 			vdisplay <<= 1;
-		if(vmode & FB_VMODE_INTERLACED) {
-			vdisplay >>= 1;
-
-			/* The prefered mode for the lcd is not interlaced, so disable it if
-			   it was enabled. For doublescan there is no problem, because we can
-			   compensate for it in the hardware stretching (we stretch half as much)
-			 */
-			vmode &= ~FB_VMODE_INTERLACED;
-			/*crtc->gen_cntl &= ~CRTC_INTERLACE_EN;*/
-		}
 		crtc->gen_cntl &= ~(CRTC2_EN | CRTC2_PIX_WIDTH);
 		crtc->lcd_gen_cntl &= ~(HORZ_DIVBY2_EN | DIS_HOR_CRT_DIVBY2 |
 			/*TVCLK_PM_EN | VCLK_DAC_PM_EN |*/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
