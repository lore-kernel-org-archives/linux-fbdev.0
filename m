From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Shift pixel value before entering loop in cfbimageblit
Date: Sat, 19 Nov 2005 09:53:15 +0800
Message-ID: <437E858B.90801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdI5F-0007L6-Sm
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 18:04:05 -0800
Received: from zproxy.gmail.com ([64.233.162.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdI5F-0003wt-N6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 18:04:05 -0800
Received: by zproxy.gmail.com with SMTP id z3so306219nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Nov 2005 18:04:05 -0800 (PST)
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

In slow imageblit, the pixel value is shifted by a certain amount
(dependent on the bpp and endianness) for each iteration.  This is
inefficient.  Better do the shifting once before going into the loop.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/cfbimgblt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index a7770c4..7a01742 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -162,6 +162,8 @@ static inline void slow_imageblit(const 
 	u32 i, j, l;
 	
 	dst2 = (u32 __iomem *) dst1;
+	fgcolor <<= LEFT_POS(bpp);
+	bgcolor <<= LEFT_POS(bpp);
 
 	for (i = image->height; i--; ) {
 		shift = val = 0;
@@ -180,7 +182,6 @@ static inline void slow_imageblit(const 
 		while (j--) {
 			l--;
 			color = (*s & 1 << (BIT_NR(l))) ? fgcolor : bgcolor;
-			color <<= LEFT_POS(bpp);
 			val |= SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
