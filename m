From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] cirrusfb: add accelerator constant
Date: Tue, 17 Mar 2009 21:05:43 +0100
Message-ID: <20090317210543.13571287.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LjfRl-0001MV-7F
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Mar 2009 19:59:33 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LjfRa-0006OM-TC for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Mar 2009 19:59:28 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add an accelerator constant so almost all
Cirrus are recognized as accelerators by
the fbset command.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 0ef7ccc..57a5856 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -517,6 +517,7 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 	int yres;
 	/* memory size in pixels */
 	unsigned pixels = info->screen_size * 8 / var->bits_per_pixel;
+	struct cirrusfb_info *cinfo = info->par;
 
 	switch (var->bits_per_pixel) {
 	case 1:
@@ -625,6 +626,9 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 	if (cirrusfb_check_pixclock(var, info))
 		return -EINVAL;
 
+	if (!is_laguna(cinfo))
+		var->accel_flags = FB_ACCELF_TEXT;
+
 	return 0;
 }
 
@@ -2027,8 +2031,12 @@ static int __devinit cirrusfb_set_fbinfo(struct fb_info *info)
 		    | FBINFO_HWACCEL_FILLRECT
 		    | FBINFO_HWACCEL_IMAGEBLIT
 		    | FBINFO_HWACCEL_COPYAREA;
-	if (noaccel || is_laguna(cinfo))
+	if (noaccel || is_laguna(cinfo)) {
 		info->flags |= FBINFO_HWACCEL_DISABLED;
+		info->fix.accel = FB_ACCEL_NONE;
+	} else
+		info->fix.accel = FB_ACCEL_CIRRUS_ALPINE;
+		
 	info->fbops = &cirrusfb_ops;
 
 	if (cinfo->btype == BT_GD5480) {
@@ -2054,7 +2062,6 @@ static int __devinit cirrusfb_set_fbinfo(struct fb_info *info)
 
 	/* FIXME: map region at 0xB8000 if available, fill in here */
 	info->fix.mmio_len   = 0;
-	info->fix.accel = FB_ACCEL_NONE;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
-- 
1.5.2.2



----------------------------------------------------------------------
Program tylko dla graczy komputerowych! 
Ogladaj >>> http://link.interia.pl/f207f 


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
