From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 16/33] pm3fb: 3 small fixes
Date: Thu, 26 Jul 2007 20:22:08 +0800
Message-ID: <46A891F0.1040408@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2uI-00011u-3a for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:57:30 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2uH-00084u-TS
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:57:30 -0700
Received: by wa-out-1112.google.com with SMTP id k22so614502waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:57:29 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch contains 3 small improvements:
- it corrects scan line width calculation in pm3fb_imageblit()
- it corrects mmio mapping for big endian machines
- it enables panning acceleration constants

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm3fb.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 280d108..fb91b64 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -558,7 +558,8 @@ static void pm3fb_imageblit(struct fb_in
 
 
 	while (height--) {
-		int width = ((image->width + 7) >> 3) + info->pixmap.scan_align;
+		int width = ((image->width + 7) >> 3)
+				+ info->pixmap.scan_align - 1;
 		width >>= 2;
 
 		while (width >= PM3_FIFO_SIZE) {
@@ -1194,6 +1195,10 @@ static int __devinit pm3fb_probe(struct 
 	 */
 	pm3fb_fix.mmio_start = pci_resource_start(dev, 0);
 	pm3fb_fix.mmio_len = PM3_REGS_SIZE;
+#if defined(__BIG_ENDIAN)
+	pm3fb_fix.mmio_start += PM3_REGS_SIZE;
+	DPRINTK("Adjusting register base for big-endian.\n");
+#endif
 
 	/* Registers - request region and map it. */
 	if (!request_mem_region(pm3fb_fix.mmio_start, pm3fb_fix.mmio_len,
@@ -1210,10 +1215,6 @@ static int __devinit pm3fb_probe(struct 
 		goto err_exit_neither;
 	}
 
-#if defined(__BIG_ENDIAN)
-	pm3fb_fix.mmio_start += PM3_REGS_SIZE;
-	DPRINTK("Adjusting register base for big-endian.\n");
-#endif
 	/* Linear frame buffer - request region and map it. */
 	pm3fb_fix.smem_start = pci_resource_start(dev, 1);
 	pm3fb_fix.smem_len = pm3fb_size_memory(par);
@@ -1243,7 +1244,8 @@ #endif
 	info->fix = pm3fb_fix;
 	info->pseudo_palette = par->palette;
 	info->flags = FBINFO_DEFAULT |
-/*			FBINFO_HWACCEL_YPAN |*/
+			FBINFO_HWACCEL_XPAN |
+			FBINFO_HWACCEL_YPAN |
 			FBINFO_HWACCEL_COPYAREA |
 			FBINFO_HWACCEL_IMAGEBLIT |
 			FBINFO_HWACCEL_FILLRECT;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
