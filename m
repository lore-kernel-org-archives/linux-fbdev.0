From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/9] fbdev: Move declaration of fb_class
	to <linux/fb.h>
Date: Sun, 27 May 2007 08:48:56 +0800
Message-ID: <4658D578.4030105@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsFPd-0001vZ-Ey for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:46 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsFPc-0003fW-7F
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:45 -0700
Received: by py-out-1112.google.com with SMTP id u77so2302792pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 May 2007 02:51:43 -0700 (PDT)
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Move the forward declaration of fb_class from drivers/video/console/fbcon.h to
<linux/fb.h>, together with the other forward declarations related to
drivers/video/fbmem.c.

This kills the following sparse warning:
| drivers/video/fbmem.c:1363:14: warning: symbol 'fb_class' was not declared. Should it be static?

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.h |    1 -
 include/linux/fb.h            |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index 71f24e0..8e6ef4b 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -176,7 +176,6 @@ extern void fbcon_set_tileops(struct vc_
 #endif
 extern void fbcon_set_bitops(struct fbcon_ops *ops);
 extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
-extern struct class *fb_class;
 
 #define FBCON_ATTRIBUTE_UNDERLINE 1
 #define FBCON_ATTRIBUTE_REVERSE   2
diff --git a/include/linux/fb.h b/include/linux/fb.h
index c654d0e..6622682 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -942,6 +942,7 @@ extern int fb_new_modelist(struct fb_inf
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
+extern struct class *fb_class;
 
 static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 					   u8 *src, u32 s_pitch, u32 height)


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
