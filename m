From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/6] vesafb: Change return error id
Date: Tue, 18 Jan 2005 05:41:05 +0800
Message-ID: <200501180541.05366.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CqeeM-0003BC-1O
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:43:02 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CqeeK-0005Rl-Fz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:43:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9614D134752B
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Jan 2005 21:41:00 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Stuart_Hayes@Dell.com

From: <Stuart_Hayes@Dell.com>

  I'm getting a message in dmesg:  "localhost kernel: vesafb: probe of
  vesafb0 failed with error -6"

  I searched the web, and found that a lot of people are getting this, but
  I couldn't find an answer, so I looked into it.

  This appears to be because "vesafb" returns -ENXIO ("No such device or
  address") when its probe function fails.  However, driverse/base/bus.c
  spews an error message during device_attach() if a matching driver's
  probe function returns anything but -ENODEV ("No such device").

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 vesafb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	2004-11-10 07:24:23 +08:00
+++ b/drivers/video/vesafb.c	2005-01-15 08:13:00 +08:00
@@ -229,7 +229,7 @@
 	unsigned int size_total;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
-		return -ENXIO;
+		return -ENODEV;
 
 	vesafb_fix.smem_start = screen_info.lfb_base;
 	vesafb_defined.bits_per_pixel = screen_info.lfb_depth;
@@ -407,7 +407,7 @@
 		(ypan) ? FBINFO_HWACCEL_YPAN : 0;
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
-		err = -ENXIO;
+		err = -ENOMEM;
 		goto err;
 	}
 	if (register_framebuffer(info)<0) {




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
