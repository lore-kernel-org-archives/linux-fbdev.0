From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/10] nvidiafb:  Some chipsets need a buffer pitch divisible by 64
Date: Sun, 6 Mar 2005 08:16:48 +0800
Message-ID: <200503060816.48035.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7jU3-00072p-T6
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:59 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7jU2-0000Ay-Im
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:59 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E6BE5F64EE6
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  6 Mar 2005 00:18:52 +0000 (UTC)
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

  The Geforce2 cards crashes at 800x600-8, but not at 640x480 or
  1024x768.  Changing the xres_virtual to be divisible by 64 fixes
  the problem.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nvidia.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-02-21 20:43:10 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-03-01 00:12:38 +08:00
@@ -1099,7 +1099,6 @@
 	var->transp.length = 0;
 
 	var->xres &= ~7;
-	var->xres_virtual &= ~7;
 
 	if (var->bits_per_pixel <= 8)
 		var->bits_per_pixel = 8;
@@ -1179,6 +1178,8 @@
 	if (var->xres_virtual < var->xres)
 		var->xres_virtual = var->xres;
 
+	var->xres_virtual = (var->xres_virtual + 63) & ~63;
+
 	vramlen = info->fix.smem_len;
 	pitch = ((var->xres_virtual * var->bits_per_pixel) + 7) / 8;
 	memlen = pitch * var->yres_virtual;
@@ -1212,7 +1213,7 @@
 			var->xres_virtual = 0x7fff;
 	}
 
-	var->xres_virtual &= ~8;
+	var->xres_virtual &= ~63;
 
 	NVTRACE_LEAVE();
 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
