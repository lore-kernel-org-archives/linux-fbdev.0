From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 1/2] atmel_lcdfb: Set ypanstep to 1 and
	enable y-panning on AT91
Date: Fri, 8 Aug 2008 14:46:43 +0200
Message-ID: <200808081446.43406.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRRMx-0003K7-Rf for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 05:46:59 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KRRMw-0002bY-EJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 05:46:59 -0700
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev-devel@lists.sourceforge.net

Panning in the y-direction can be done by simply changing the DMA base
address. This code is already in place, but FBIOPAN_DISPLAY will
currently fail because ypanstep is 0.

Set ypanstep to 1 to indicate that we do support y-panning and also
set the necessary acceleration flags on AT91 (AVR32 already have
them.)

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/video/atmel_lcdfb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 5b3a15d..e1acfa7 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -39,7 +39,9 @@
 #endif
 
 #if defined(CONFIG_ARCH_AT91)
-#define	ATMEL_LCDFB_FBINFO_DEFAULT	FBINFO_DEFAULT
+#define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
+					 | FBINFO_PARTIAL_PAN_OK \
+					 | FBINFO_HWACCEL_YPAN)
 
 static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
 					struct fb_var_screeninfo *var)
@@ -177,7 +179,7 @@ static struct fb_fix_screeninfo atmel_lcdfb_fix __initdata 
= {
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_TRUECOLOR,
 	.xpanstep	= 0,
-	.ypanstep	= 0,
+	.ypanstep	= 1,
 	.ywrapstep	= 0,
 	.accel		= FB_ACCEL_NONE,
 };
-- 
1.5.2.5


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
