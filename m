From: syrjala@sci.fi
Subject: [PATCH 3/8] atyfb: Don't stretch with CRT
Date: Thu, 17 Mar 2005 05:07:52 +0200 (EET)
Message-ID: <20050317030752.325B77A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBlMZ-000580-VI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 19:07:55 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DBlMX-0003IY-6B
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 19:07:55 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 5C989DC655
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Mar 2005 05:07:52 +0200 (EET)
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
Cc: alex.kern@gmx.de

The overlay on 3D Rage LT Pro doesn't work correctly if stretching is 
enabled when using only a CRT.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 atyfb_base.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urN linux/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2005-03-16 18:58:33.000000000 +0200
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-16 19:02:03.000000000 +0200
@@ -994,7 +994,7 @@
 		crtc->horz_stretching &=
 			~(HORZ_STRETCH_RATIO | HORZ_STRETCH_LOOP | AUTO_HORZ_RATIO |
 			HORZ_STRETCH_MODE | HORZ_STRETCH_EN);
-		if (xres < par->lcd_width) {
+		if (xres < par->lcd_width && crtc->lcd_gen_cntl & LCD_ON) {
 			do {
 				/*
 				* The horizontal blender misbehaves when HDisplay is less than a
@@ -1056,7 +1056,7 @@
 			} while (0);
 		}
 
-		if (vdisplay < par->lcd_height) {
+		if (vdisplay < par->lcd_height && crtc->lcd_gen_cntl & LCD_ON) {
 			crtc->vert_stretching = (VERT_STRETCH_USE0 | VERT_STRETCH_EN |
 				(((vdisplay * (VERT_STRETCH_RATIO0 + 1)) / par->lcd_height) & VERT_STRETCH_RATIO0));
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
