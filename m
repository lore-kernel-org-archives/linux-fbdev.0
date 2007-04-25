From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 24/41] hecubafb: Us fb_sys_read()
Date: Wed, 25 Apr 2007 14:51:12 +0800
Message-ID: <462EFA60.70604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcFL-0001wl-S2 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:49:03 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc9Z-0002pB-Nb
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:05 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:43:05 -0700 (PDT)
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

Since hecubafb's framebuffer is vmalloc'ed, use fb_sys_read().

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig    |    1 +
 drivers/video/hecubafb.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6ec096a..605feff 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -608,6 +608,7 @@ config FB_HECUBA
        select FB_SYS_FILLRECT
        select FB_SYS_COPYAREA
        select FB_SYS_IMAGEBLIT
+       select FB_SYS_FOPS
        select FB_DEFERRED_IO
        help
          This enables support for the Hecuba board. This driver was tested
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index 3ec0e97..abfcb50 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -309,6 +309,7 @@ static ssize_t hecubafb_write(struct fb_
 
 static struct fb_ops hecubafb_ops = {
 	.owner		= THIS_MODULE,
+	.fb_read        = fb_sys_read,
 	.fb_write	= hecubafb_write,
 	.fb_fillrect	= hecubafb_fillrect,
 	.fb_copyarea	= hecubafb_copyarea,


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
