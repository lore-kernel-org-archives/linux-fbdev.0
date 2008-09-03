From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 2/2] atmel_lcdfb: Disallow to set larger
	resolution than framebuffer memory can handle
Date: Wed, 3 Sep 2008 15:37:40 +0200
Message-ID: <200809031537.40702.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KasXQ-0001Xg-E1 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 06:36:48 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KasXQ-0003Vm-1H
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 06:36:48 -0700
Received: from ebg226.internetdsl.tpnet.pl (HELO [192.168.1.13])
	(stf_xl@wp.pl@[83.14.136.226]) (envelope-sender <stf_xl@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 3 Sep 2008 15:36:45 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/video/atmel_lcdfb.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 3376f35..5d6cf33 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -342,6 +342,13 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
 	var->transp.offset = var->transp.length = 0;
 	var->xoffset = var->yoffset = 0;
 
+	if (info->fix.smem_len) {
+		unsigned int smem_len = (var->xres_virtual * var->yres_virtual
+					 * ((var->bits_per_pixel + 7) / 8));
+		if (smem_len > info->fix.smem_len)
+			return -EINVAL;
+	}
+
 	/* Saturate vertical and horizontal timings at maximum values */
 	var->vsync_len = min_t(u32, var->vsync_len,
 			(ATMEL_LCDC_VPW >> ATMEL_LCDC_VPW_OFFSET) + 1);
-- 
1.5.2.5


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
