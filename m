From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/7] neofb: Set hwaccel flags properly
Date: Sun, 20 Mar 2005 21:10:01 +0800
Message-ID: <200503202110.01014.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD0Cq-0001Ga-16
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:11:00 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DD0Cp-0007o1-1I
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:59 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7ED9814CE5FA
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Mar 2005 13:10:52 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  Not all neomagic chipsets are capable of hardware acceleration.
  Set the hwaccel flags only for chipsets that can do so.

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 neofb.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	2005-03-19 05:33:32 +08:00
+++ b/drivers/video/neofb.c	2005-03-19 06:10:30 +08:00
@@ -2030,6 +2030,7 @@
 
 	par->internal_display = internal;
 	par->external_display = external;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 
 	switch (info->fix.accel) {
 	case FB_ACCEL_NEOMAGIC_NM2070:
@@ -2049,15 +2050,27 @@
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2200:
 		sprintf(info->fix.id, "MagicGraph 256AV");
+		info->flags |= FBINFO_HWACCEL_IMAGEBLIT |
+		               FBINFO_HWACCEL_COPYAREA |
+                	       FBINFO_HWACCEL_FILLRECT;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2230:
 		sprintf(info->fix.id, "MagicGraph 256AV+");
+		info->flags |= FBINFO_HWACCEL_IMAGEBLIT |
+		               FBINFO_HWACCEL_COPYAREA |
+                	       FBINFO_HWACCEL_FILLRECT;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2360:
 		sprintf(info->fix.id, "MagicGraph 256ZX");
+		info->flags |= FBINFO_HWACCEL_IMAGEBLIT |
+		               FBINFO_HWACCEL_COPYAREA |
+                	       FBINFO_HWACCEL_FILLRECT;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2380:
 		sprintf(info->fix.id, "MagicGraph 256XL+");
+		info->flags |= FBINFO_HWACCEL_IMAGEBLIT |
+		               FBINFO_HWACCEL_COPYAREA |
+                	       FBINFO_HWACCEL_FILLRECT;
 		break;
 	}
 
@@ -2069,9 +2082,6 @@
 	info->fix.accel = id->driver_data;
 
 	info->fbops = &neofb_ops;
-	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
-		FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_COPYAREA |
-		FBINFO_HWACCEL_COPYAREA;
 	info->pseudo_palette = (void *) (par + 1);
 	return info;
 }




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
