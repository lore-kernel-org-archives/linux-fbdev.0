From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/8] fbdev: Set color depth to 8 if in pseudocolor in vesafb.
Date: Mon, 8 Nov 2004 05:29:17 +0800
Message-ID: <20041107213325.7A0DF11C60C1@smtp-3.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQufS-00040o-T4
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:33:46 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQufR-00071L-8s
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:33:46 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0DD109BF05F
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Nov 2004 21:33:30 +0000 (UTC)
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

Set color depth to 8 if in pseudocolor in vesafb.  The CLUT size, previously
saved as {red|green|blue}.length, is now  private to vesafb.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 vesafb.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	2004-10-19 20:22:31 +08:00
+++ b/drivers/video/vesafb.c	2004-11-07 19:26:56 +08:00
@@ -56,6 +56,7 @@
 static unsigned short  *pmi_base  = NULL;
 static void            (*pmi_start)(void);
 static void            (*pmi_pal)(void);
+static int             depth;
 
 /* --------------------------------------------------------------------- */
 
@@ -89,11 +90,11 @@
 }
 
 static void vesa_setpalette(int regno, unsigned red, unsigned green,
-			    unsigned blue, struct fb_var_screeninfo *var)
+			    unsigned blue)
 {
 #ifdef __i386__
 	struct { u_char blue, green, red, pad; } entry;
-	int shift = 16 - var->green.length;
+	int shift = 16 - depth;
 
 	if (pmi_setpal) {
 		entry.red   = red   >> shift;
@@ -135,7 +136,7 @@
 
 	switch (info->var.bits_per_pixel) {
 	case 8:
-		vesa_setpalette(regno,red,green,blue, &info->var);
+		vesa_setpalette(regno,red,green,blue);
 		break;
 	case 16:
 		if (info->var.red.offset == 10) {
@@ -358,6 +359,15 @@
 	vesafb_defined.blue.length   = screen_info.blue_size;
 	vesafb_defined.transp.offset = screen_info.rsvd_pos;
 	vesafb_defined.transp.length = screen_info.rsvd_size;
+
+	if (vesafb_defined.bits_per_pixel <= 8) {
+		depth = vesafb_defined.green.length;
+		vesafb_defined.red.length =
+		vesafb_defined.green.length =
+		vesafb_defined.blue.length =
+		vesafb_defined.bits_per_pixel;
+	}
+
 	printk(KERN_INFO "vesafb: %s: "
 	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
 	       (vesafb_defined.bits_per_pixel > 8) ?





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
