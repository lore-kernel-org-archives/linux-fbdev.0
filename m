From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 9/9] fbdev: Reduce stack usage of intelfb
Date: Tue, 21 Dec 2004 23:34:31 +0800
Message-ID: <20041221213729.2EE321A01F5@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CgrhX-0007pP-2m
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:51 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CgrhW-0002Yq-IZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:50 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6EBABBFF729
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Dec 2004 21:37:37 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Randy.Dunlap" <randy.dunlap@verizon.net>

Reduce stack usage in intelfb_set_par() from 2404 bytes
(on x86-32) to 12 bytes.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 intelfbdrv.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c	2004-11-17 18:15:18 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2004-12-21 04:59:25 +08:00
@@ -1234,8 +1234,7 @@
 static int
 intelfb_set_par(struct fb_info *info)
 {
-	struct intelfb_hwstate hw;
-
+ 	struct intelfb_hwstate *hw;
         struct intelfb_info *dinfo = GET_DINFO(info);
 
 	if (FIXED_MODE(dinfo)) {
@@ -1243,6 +1242,10 @@
 		return -EINVAL;
 	}
 
+ 	hw = kmalloc(sizeof(*hw), GFP_ATOMIC);
+ 	if (!hw)
+ 		return -ENOMEM;
+
 	DBG_MSG("intelfb_set_par (%dx%d-%d)\n", info->var.xres,
 		info->var.yres, info->var.bits_per_pixel);
 
@@ -1251,15 +1254,15 @@
 	if (dinfo->accel)
 		intelfbhw_2d_stop(dinfo);
 
-	hw = dinfo->save_state;
-	if (intelfbhw_mode_to_hw(dinfo, &hw, &info->var))
-		return -EINVAL;
-	if (intelfbhw_program_mode(dinfo, &hw, 0))
-		return -EINVAL;
+ 	memcpy(hw, &dinfo->save_state, sizeof(*hw));
+ 	if (intelfbhw_mode_to_hw(dinfo, hw, &info->var))
+ 		goto invalid_mode;
+ 	if (intelfbhw_program_mode(dinfo, hw, 0))
+ 		goto invalid_mode;
 
 #if REGDUMP > 0
-	intelfbhw_read_hw_state(dinfo, &hw, 0);
-	intelfbhw_print_hw_state(dinfo, &hw);
+ 	intelfbhw_read_hw_state(dinfo, hw, 0);
+ 	intelfbhw_print_hw_state(dinfo, hw);
 #endif
 
 	update_dinfo(dinfo, &info->var);
@@ -1278,7 +1281,11 @@
 	} else {
 		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	}
+	kfree(hw);
 	return 0;
+invalid_mode:
+	kfree(hw);
+	return -EINVAL;
 }
 
 static int




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
