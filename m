From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/7] s3fb: Implement fb_get_caps
Date: Sun, 29 Apr 2007 11:47:44 +0800
Message-ID: <46341560.1060109@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hi0TV-0003bS-Io for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:30 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hi0TV-000446-2n
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:25 -0700
Received: by py-out-1112.google.com with SMTP id a29so1108343pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 28 Apr 2007 20:53:24 -0700 (PDT)
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

Implement fb_get_caps(). This will allow the driver to tell upper layer that
it can only support 256 8x16 bitmaps when in tileblitting mode
(var->bits_per_pixel == 0);

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3fb.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index dfa717b..4d0e204 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -799,6 +799,23 @@ static int s3fb_pan_display(struct fb_va
 	return 0;
 }
 
+/* Get capabilities of accelerator based on the mode */
+
+static void s3fb_get_caps(struct fb_info *info, struct fb_blit_caps *caps,
+			  struct fb_var_screeninfo *var)
+{
+	if (var->bits_per_pixel == 0) {
+		/* can only support 256 8x16 bitmap */
+		caps->x = 1 << (8 - 1);
+		caps->y = 1 << (16 - 1);
+		caps->len = 256;
+	} else {
+		caps->x = ~(u32)0;
+		caps->y = ~(u32)0;
+		caps->len = ~(u32)0;
+	}
+}
+
 /* ------------------------------------------------------------------------- */
 
 /* Frame buffer operations */
@@ -815,6 +832,7 @@ static struct fb_ops s3fb_ops = {
 	.fb_fillrect	= s3fb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= s3fb_imageblit,
+	.fb_get_caps    = s3fb_get_caps,
 };
 
 /* ------------------------------------------------------------------------- */


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
