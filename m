From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Optimizing bitblit.c / fb_pad_*
Date: Sat, 30 Jul 2005 11:21:47 +0200
Message-ID: <42EB46AB.1010005@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DynW5-0006WB-Hb
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 02:20:25 -0700
Received: from mailout09.sul.t-online.com ([194.25.134.84])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DynW3-00050R-NS
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 02:20:25 -0700
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi everybody,

could you please verify this change to bitblit.c.

Advantage: For drivers with accelerated blitting a significant 
performance boost.

The execution time for my test3 with cyblafb and ypanning drops from
0,870s (2.6.13-rc4 with the patch from Antonino) to 0,772s.

If you agree that this is the way to go, we should add some additional 
code for font
resolutions different from 8x16.

Should we drop fb_pad_aligned() entirely from the kernel? As far as I 
see it is only
used in cases that do not copy too much data. Replacing fb_pad_aligned 
at those places
with proper inline code should also help to optimize performance.


cu,
 Knut


--- linux-2.6.13-rc4/drivers/video/console/bitblit.c	2005-07-29 10:01:01.000000000 +0200
+++ linux/drivers/video/console/bitblit.c	2005-07-30 09:34:49.000000000 +0200
@@ -113,12 +113,15 @@
 	unsigned int maxcnt = info->pixmap.size/cellsize;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int buf_align = info->pixmap.buf_align - 1;
-	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
-	unsigned int shift_high = 8, pitch, cnt, size, k;
+	unsigned int shift_low = 0;
+	unsigned int mod = vc->vc_font.width % 8;
 	unsigned int idx = vc->vc_font.width >> 3;
 	unsigned int attribute = get_attribute(info, scr_readw(s));
+	unsigned int shift_high = 8;
+	unsigned int pitch, cnt, size, k;
+	unsigned int fast_8x16, i, j;
 	struct fb_image image;
-	u8 *src, *dst, *buf = NULL;
+	u8 *src, *dst, *dstp, *buf = NULL;
 
 	if (attribute) {
 		buf = kmalloc(cellsize, GFP_KERNEL);
@@ -134,6 +137,11 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
+	if (vc->vc_font.height == 16 && vc->vc_font.width == 8)
+		fast_8x16 = 1;
+	else
+		fast_8x16 = 0;
+
 	while (count) {
 		if (count > maxcnt)
 			cnt = k = maxcnt;
@@ -147,7 +155,8 @@
 		size &= ~buf_align;
 		dst = fb_get_buffer_offset(info, &info->pixmap, size);
 		image.data = dst;
-		if (mod) {
+
+		if (!mod)
 			while (k--) {
 				src = vc->vc_font.data + (scr_readw(s++)&
 							  charmask)*cellsize;
@@ -157,15 +166,23 @@
 					src = buf;
 				}
 
-				fb_pad_unaligned_buffer(dst, pitch, src, idx,
-						image.height, shift_high,
-						shift_low, mod);
-				shift_low += mod;
-				dst += (shift_low >= 8) ? width : width - 1;
-				shift_low &= 7;
-				shift_high = 8 - shift_low;
+				// Optimized for speed, memcpy() is too slow!
+				dstp = dst;
+				if (fast_8x16)
+					for (i = 16; i--; ) {
+						*dstp = src[15-i];
+						dstp += pitch;
+					}
+				else
+					for (i = image.height; i--; ) {
+						for (j = 0; j < idx; j++)
+							dstp[j] = src[j];
+						src += idx;
+						dstp += pitch;
+					}
+				dst += width;
 			}
-		} else {
+		else
 			while (k--) {
 				src = vc->vc_font.data + (scr_readw(s++)&
 							  charmask)*cellsize;
@@ -175,10 +192,15 @@
 					src = buf;
 				}
 
-				fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
-				dst += width;
+				fb_pad_unaligned_buffer(dst, pitch, src, idx,
+						image.height, shift_high,
+						shift_low, mod);
+				shift_low += mod;
+				dst += (shift_low >= 8) ? width : width - 1;
+				shift_low &= 7;
+				shift_high = 8 - shift_low;
 			}
-		}
+
 		info->fbops->fb_imageblit(info, &image);
 		image.dx += cnt * vc->vc_font.width;
 		count -= cnt;




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
