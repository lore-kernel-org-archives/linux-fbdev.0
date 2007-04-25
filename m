From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 32/41] s3fb: Implement fb_get_tilemax()
Date: Wed, 25 Apr 2007 15:11:29 +0800
Message-ID: <462EFF21.4030708@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcBm-0001aH-GM for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:45:22 -0700
Received: from wx-out-0506.google.com ([66.249.82.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcBl-0004Ut-7B
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:45:22 -0700
Received: by wx-out-0506.google.com with SMTP id i30so296332wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:45:20 -0700 (PDT)
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

Implement fb_get_tilemax(). It just returns 256.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3fb.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 53f1eb9..2a8d7d3 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -183,7 +183,10 @@ static void s3fb_settile_fast(struct fb_
 	}
 }
 
-
+static int s3fb_get_tilemax(struct fb_info *info)
+{
+	return 256;
+}
 
 static struct fb_tile_ops s3fb_tile_ops = {
 	.fb_settile	= svga_settile,
@@ -191,6 +194,7 @@ static struct fb_tile_ops s3fb_tile_ops 
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
 	.fb_tilecursor  = svga_tilecursor,
+	.fb_get_tilemax = s3fb_get_tilemax,
 };
 
 static struct fb_tile_ops s3fb_fast_tile_ops = {
@@ -199,6 +203,7 @@ static struct fb_tile_ops s3fb_fast_tile
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
 	.fb_tilecursor  = svga_tilecursor,
+	.fb_get_tilemax = s3fb_get_tilemax,
 };
 
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
