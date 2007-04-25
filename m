From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 27/41] fbdev: Advertise limitation of
	drawing engine
Date: Wed, 25 Apr 2007 14:56:52 +0800
Message-ID: <462EFBB4.1080900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcA6-0001MN-Fc for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:38 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcA6-00044I-3j
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:38 -0700
Received: by py-out-1112.google.com with SMTP id a29so117101pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:43:37 -0700 (PDT)
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
Cc: Ondrej Zajicek <santiago@mail.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

A few drivers are not capable of blitting rectangles of any dimension.
vga16fb can only blit 8-pixel wide rectangles, while s3fb (in tileblitting
mode) can only blit 8x16 rectangles.  For example, loading a 12x22 font in
vga16fb will result in a corrupt display.

Advertise this limitation/capability in info->pixmap.blit_x and blit_y.  These
fields are 32-bit arrays (font max is 32x32 only), ie, if bit 7 is set, then
width/height of 7+1 is supported.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fbmem.c |    6 ++++++
 include/linux/fb.h    |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 7b72841..c4ce3e4 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1321,6 +1321,12 @@ register_framebuffer(struct fb_info *fb_
 	}	
 	fb_info->pixmap.offset = 0;
 
+	if (!fb_info->pixmap.blit_x)
+		fb_info->pixmap.blit_x = ~(u32)0;
+
+	if (!fb_info->pixmap.blit_y)
+		fb_info->pixmap.blit_y = ~(u32)0;
+
 	if (!fb_info->modelist.prev || !fb_info->modelist.next)
 		INIT_LIST_HEAD(&fb_info->modelist);
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 70d154a..619ba1e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -558,6 +558,10 @@ struct fb_pixmap {
 	u32 scan_align;		/* alignment per scanline		*/
 	u32 access_align;	/* alignment per read/write (bits)	*/
 	u32 flags;		/* see FB_PIXMAP_*			*/
+	u32 blit_x;             /* supported bit block dimensions (1-32)*/
+	u32 blit_y;             /* Format: blit_x = 1 << (width - 1)    */
+	                        /*         blit_y = 1 << (height - 1)   */
+	                        /* if 0, will be set to 0xffffffff (all)*/
 	/* access methods */
 	void (*writeio)(struct fb_info *info, void __iomem *dst, void *src, unsigned int size);
 	void (*readio) (struct fb_info *info, void *dst, void __iomem *src, unsigned int size);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
