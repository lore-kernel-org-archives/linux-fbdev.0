From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] gxfb: Get the frambuffer size from the
	BIOS
Date: Mon, 05 Jun 2006 07:17:44 +0800
Message-ID: <44836A18.5040407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnRs8-0002YP-72 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 20:04:48 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fn8OA-0003E9-IF for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 23:16:34 -0700
Received: from wx-out-0102.google.com ([66.249.82.195])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fn1r0-0004VK-F4
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 16:17:57 -0700
Received: by wx-out-0102.google.com with SMTP id s18so598245wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 04 Jun 2006 16:17:52 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jordan Crouse <jordan.crouse@amd.com>, David Vrabel <dvrabel@arcom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jordan Crouse <jordan.crouse@amd.com>

Use the Geode GX BIOS virtual registers to get the actual size of the
framebuffer.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Signed-off-by: David Vrabel <dvrabel@arcom.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/geode/display_gx.c |   15 ++++++++++++---
 drivers/video/geode/display_gx.h |    2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/video/geode/display_gx.c b/drivers/video/geode/display_gx.c
index 825c340..7c39925 100644
--- a/drivers/video/geode/display_gx.c
+++ b/drivers/video/geode/display_gx.c
@@ -21,10 +21,19 @@ #include <asm/delay.h>
 #include "geodefb.h"
 #include "display_gx.h"
 
-int gx_frame_buffer_size(void)
+unsigned int gx_frame_buffer_size(void)
 {
-	/* Assuming 16 MiB. */
-	return 16*1024*1024;
+	unsigned int val;
+
+	/* FB size is reported by a virtual register */
+	/* Virtual register class = 0x02 */
+	/* VG_MEM_SIZE(512Kb units) = 0x00 */
+
+	outw(0XFC53, 0xAC1C);
+	outw(0x0200, 0xAC1C);
+
+	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
+	return (val << 19);
 }
 
 int gx_line_delta(int xres, int bpp)
diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
index 86c6233..41e79f4 100644
--- a/drivers/video/geode/display_gx.h
+++ b/drivers/video/geode/display_gx.h
@@ -11,7 +11,7 @@
 #ifndef __DISPLAY_GX_H__
 #define __DISPLAY_GX_H__
 
-int gx_frame_buffer_size(void);
+unsigned int gx_frame_buffer_size(void);
 int gx_line_delta(int xres, int bpp);
 
 extern struct geode_dc_ops gx_dc_ops;
