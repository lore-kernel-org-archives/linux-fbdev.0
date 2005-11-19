From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbcon: Console Rotation - Fix wrong shift calculation
Date: Sat, 19 Nov 2005 09:47:17 +0800
Message-ID: <437E8425.3040706@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdI53-0007K8-J4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 18:03:53 -0800
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdI51-0003te-6c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 18:03:53 -0800
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
Cc: linux-fbdev-devel@lists.sf.net

The shift value (amount to shift the bitmap so first pixel starts at
origin(0,0)) is incorrect. This causes corrupted characters or a kernel
crash if fontwidth is not divisible by 8 at 270 degrees, or fontheight
not divisible by 8 at 180 degrees.

Report and part of the fix contributed by Knut Petersen.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon_rotate.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/fbcon_rotate.h b/drivers/video/console/fbcon_rotate.h
index 90c6720..e504fbf 100644
--- a/drivers/video/console/fbcon_rotate.h
+++ b/drivers/video/console/fbcon_rotate.h
@@ -49,7 +49,7 @@ static inline void pattern_set_bit(u32 x
 static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
 {
 	int i, j;
-	int shift = width % 8;
+	int shift = (8 - (width % 8)) & 7;
 
 	width = (width + 7) & ~7;
 
@@ -85,7 +85,7 @@ static inline void rotate_cw(const char 
 static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
 {
 	int i, j, h = height, w = width;
-	int shift = width % 8;
+	int shift = (8 - (width % 8)) & 7;
 
 	width = (width + 7) & ~7;
 	height = (height + 7) & ~7;




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
