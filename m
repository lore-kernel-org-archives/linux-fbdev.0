From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/4] fbdev: Fix lockup when switching to/from X/console
Date: Mon, 22 Nov 2004 07:16:51 +0800
Message-ID: <200411220716.51948.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CW10T-0002XU-Np
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Nov 2004 15:20:33 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CW106-0005TJ-Cs
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Nov 2004 15:20:33 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 94F55A17D18
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Nov 2004 23:19:56 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- Do a set_par very late instead of during fbcon_blank by setting the
  FBINFO_MISC_MODESWITCHLATE flag which should help prevent
  lockups when switching from X
- Shorten chipset names that were missed before
- Do not validate modeline if monitor specifications are not available

Signed-off-by: Antonino Daplas <adaplas@pol.net>
--- 

 savagefb.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff -Nru a/drivers/video/savage/savagefb.c b/drivers/video/savage/savagefb.c
--- a/drivers/video/savage/savagefb.c	2004-11-17 18:15:21 +08:00
+++ b/drivers/video/savage/savagefb.c	2004-11-22 06:44:00 +08:00
@@ -719,7 +719,8 @@
 		return -EINVAL;
 	}
 
-	if (!fb_validate_mode(var, info))
+	if (!info->monspecs.hfmax || !info->monspecs.vfmax ||
+	    !info->monspecs.dclkmax || !fb_validate_mode(var, info))
 		mode_valid = 1;
 
 	/* calculate modeline if supported by monitor */
@@ -1801,23 +1802,23 @@
 	switch (info->fix.accel) {
 	case FB_ACCEL_SUPERSAVAGE:
 		par->chip = S3_SUPERSAVAGE;
-		snprintf (info->fix.id, 16, "S3 SuperSavage");
+		snprintf (info->fix.id, 16, "SuperSavage");
 		break;
 	case FB_ACCEL_SAVAGE4:
 		par->chip = S3_SAVAGE4;
-		snprintf (info->fix.id, 16, "S3 Savage4");
+		snprintf (info->fix.id, 16, "Savage4");
 		break;
 	case FB_ACCEL_SAVAGE3D:
 		par->chip = S3_SAVAGE3D;
-		snprintf (info->fix.id, 16, "S3 Savage3D");
+		snprintf (info->fix.id, 16, "Savage3D");
 		break;
 	case FB_ACCEL_SAVAGE3D_MV:
 		par->chip = S3_SAVAGE3D;
-		snprintf (info->fix.id, 16, "S3 Savage3D-MV");
+		snprintf (info->fix.id, 16, "Savage3D-MV");
 		break;
 	case FB_ACCEL_SAVAGE2000:
 		par->chip = S3_SAVAGE2000;
-		snprintf (info->fix.id, 16, "S3 Savage2000");
+		snprintf (info->fix.id, 16, "Savage2000");
 		break;
 	case FB_ACCEL_SAVAGE_MX_MV:
 		par->chip = S3_SAVAGE_MX;
@@ -1882,7 +1883,8 @@
 	info->fbops          = &savagefb_ops;
 	info->flags          = FBINFO_DEFAULT |
 		               FBINFO_HWACCEL_YPAN |
-		               FBINFO_HWACCEL_XPAN;
+		               FBINFO_HWACCEL_XPAN |
+	                       FBINFO_MISC_MODESWITCHLATE;
 
 	info->pseudo_palette = par->pseudo_palette;
 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
