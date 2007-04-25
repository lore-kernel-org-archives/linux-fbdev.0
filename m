From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 31/41] fbdev: Add tile operation to get
 the maximum length of the map
Date: Wed, 25 Apr 2007 15:10:32 +0800
Message-ID: <462EFEE8.60206@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcBO-0001UM-51 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:44:58 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcBL-0004N6-Ik
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:44:58 -0700
Received: by py-out-1112.google.com with SMTP id a29so117360pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:44:55 -0700 (PDT)
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

Add a tile method, fb_get_tilemax(), that returns the maximum length of
the tile map (or font map).  This is needed by s3fb which can only handle
256 characters.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 include/linux/fb.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 619ba1e..a2f382c 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -655,7 +655,6 @@ struct fb_ops {
 };
 
 #ifdef CONFIG_FB_TILEBLITTING
-
 #define FB_TILE_CURSOR_NONE        0
 #define FB_TILE_CURSOR_UNDERLINE   1
 #define FB_TILE_CURSOR_LOWER_THIRD 2
@@ -727,6 +726,8 @@ struct fb_tile_ops {
 	/* cursor */
 	void (*fb_tilecursor)(struct fb_info *info,
 			      struct fb_tilecursor *cursor);
+	/* get maximum length of the tile map */
+	int (*fb_get_tilemax)(struct fb_info *info);
 };
 #endif /* CONFIG_FB_TILEBLITTING */
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
