From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/8] fbdev: Support for bigger than 16x32 fonts in softcursor
Date: Thu, 11 Nov 2004 10:15:20 +0800
Message-ID: <20041111022436.8F2AD1A022D@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CS4fW-000558-Ua
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:26:38 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CS4fW-0006tr-8x
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:26:38 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6BD5A9D408C
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Nov 2004 02:26:30 +0000 (UTC)
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

Fix crash if font font is bigger than 16x32 by dynamically allocating buffer
based on font dimensions instead of statically allocating at 64 bytes.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 softcursor.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -Nru a/drivers/video/softcursor.c b/drivers/video/softcursor.c
--- a/drivers/video/softcursor.c	2004-10-23 02:52:37 +08:00
+++ b/drivers/video/softcursor.c	2004-11-08 18:10:58 +08:00
@@ -28,16 +28,17 @@
 	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
-	src = kmalloc(64 + sizeof(struct fb_image), GFP_ATOMIC);
+	s_pitch = (cursor->image.width + 7) >> 3;
+	dsize = s_pitch * cursor->image.height;
 
+	src = kmalloc(dsize + sizeof(struct fb_image), GFP_ATOMIC);
 	if (!src)
 		return -ENOMEM;
 
-	image = (struct fb_image *) (src + 64);
+	image = (struct fb_image *) (src + dsize);
 	*image = cursor->image;
-	s_pitch = (image->width + 7) >> 3;
-	dsize = s_pitch * image->height;
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
+
 	size = d_pitch * image->height + buf_align;
 	size &= ~buf_align;
 	dst = fb_get_buffer_offset(info, &info->pixmap, size);





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
