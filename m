From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 23/41] arcfb: Us fb_sys_read()
Date: Wed, 25 Apr 2007 14:50:20 +0800
Message-ID: <462EFA2C.8060102@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcPR-00038x-ET for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:59:29 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc9N-0002pB-FO
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:42:53 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:42:53 -0700 (PDT)
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
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Since arcfb's framebuffer is vmalloc'ed, use the fb_sys_read().

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig |    1 +
 drivers/video/arcfb.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5b6350d..6ec096a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -420,6 +420,7 @@ config FB_ARC
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
 	help
 	  This enables support for the Arc Monochrome LCD board. The board
 	  is based on the KS-108 lcd controller and is typically a matrix
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index c668e56..db15bac 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -494,6 +494,7 @@ static ssize_t arcfb_write(struct fb_inf
 static struct fb_ops arcfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_open	= arcfb_open,
+	.fb_read        = fb_sys_read,
 	.fb_write	= arcfb_write,
 	.fb_release	= arcfb_release,
 	.fb_pan_display	= arcfb_pan_display,


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
