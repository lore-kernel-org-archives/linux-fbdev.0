From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/6] nvidiafb: Maximize blit buffer capacity
Date: Sun, 13 Mar 2005 08:34:15 +0800
Message-ID: <200503130834.15823.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAH67-0003qj-RM
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:47 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAH67-0006S7-Au
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:47 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D57FEF9EAAA
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 00:36:14 +0000 (UTC)
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

  Currently, nvidiafb blit expands a rectangle a scanline at a time.
  This is very inefficient because the graphics pipeline is not
  maximized. It may also crash if the scanline is > 4096 (should
  not happen with fbcon though).

  Instead of blitting a scanline at a time, attempt to fill up buffer
  to maximum capacity.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nv_accel.c |   20 +++++++++++++++++---
 nv_local.h |    3 +--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff -Nru a/drivers/video/nvidia/nv_accel.c b/drivers/video/nvidia/nv_accel.c
--- a/drivers/video/nvidia/nv_accel.c	2005-03-12 23:25:08 +08:00
+++ b/drivers/video/nvidia/nv_accel.c	2005-03-11 13:32:06 +08:00
@@ -359,10 +359,10 @@
 	struct nvidia_par *par = info->par;
 	u32 fg, bg, mask = ~(~0 >> (32 - info->var.bits_per_pixel));
 	u32 dsize, width, *data = (u32 *) image->data, tmp;
-	int i, j, k = 0;
+	int j, k = 0;
 
 	width = (image->width + 31) & ~31;
-	dsize = width >> 5;
+	dsize = (width * image->height) >> 5;
 
 	if (info->var.bits_per_pixel == 8) {
 		fg = image->fg_color | mask;
@@ -382,8 +382,22 @@
 	NVDmaNext(par, (image->height << 16) | width);
 	NVDmaNext(par, (image->dy << 16) | (image->dx & 0xffff));
 
-	for (i = image->height; i--;) {
+	while (dsize >= RECT_EXPAND_TWO_COLOR_DATA_MAX_DWORDS) {
+		NVDmaStart(par, RECT_EXPAND_TWO_COLOR_DATA(0),
+			   RECT_EXPAND_TWO_COLOR_DATA_MAX_DWORDS);
+
+		for (j = RECT_EXPAND_TWO_COLOR_DATA_MAX_DWORDS; j--;) {
+			tmp = data[k++];
+			reverse_order(&tmp);
+			NVDmaNext(par, tmp);
+		}
+
+		dsize -= RECT_EXPAND_TWO_COLOR_DATA_MAX_DWORDS;
+	}
+
+	if (dsize) {
 		NVDmaStart(par, RECT_EXPAND_TWO_COLOR_DATA(0), dsize);
+
 		for (j = dsize; j--;) {
 			tmp = data[k++];
 			reverse_order(&tmp);
diff -Nru a/drivers/video/nvidia/nv_local.h b/drivers/video/nvidia/nv_local.h
--- a/drivers/video/nvidia/nv_local.h	2005-03-12 23:25:10 +08:00
+++ b/drivers/video/nvidia/nv_local.h	2005-03-11 13:32:06 +08:00
@@ -87,9 +87,8 @@
 #endif
 
 #define WRITE_PUT(par, data) {                   \
-  volatile u8 scratch;                           \
   _NV_FENCE()                                    \
-  scratch = NV_RD08((par)->FbStart, 0);          \
+  NV_RD08((par)->FbStart, 0);                    \
   NV_WR32(&(par)->FIFO[0x0010], 0, (data) << 2); \
   mb();                                          \
 }




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
