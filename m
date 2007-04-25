From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 25/41] vfb: Us fb_sys_read() and
	fb_sys_write()
Date: Wed, 25 Apr 2007 14:51:57 +0800
Message-ID: <462EFA8D.1080402@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc9k-0001Le-7c for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:17 -0700
Received: from nz-out-0506.google.com ([64.233.162.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc9j-0006pM-RD
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:16 -0700
Received: by nz-out-0506.google.com with SMTP id i11so418229nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:43:15 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Since vfb's framebuffer is vmalloc'ed, use the fb_sys_read() and
fb_sys_write().

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig |    1 +
 drivers/video/vfb.c   |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 605feff..61931da 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1714,6 +1714,7 @@ config FB_VIRTUAL
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
 	---help---
 	  This is a `virtual' frame buffer device. It operates on a chunk of
 	  unswappable kernel memory instead of on the memory of a graphics
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 1293c20..64ee78c 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -84,6 +84,8 @@ static int vfb_mmap(struct fb_info *info
 		    struct vm_area_struct *vma);
 
 static struct fb_ops vfb_ops = {
+	.fb_read        = fb_sys_read,
+	.fb_write       = fb_sys_write,
 	.fb_check_var	= vfb_check_var,
 	.fb_set_par	= vfb_set_par,
 	.fb_setcolreg	= vfb_setcolreg,


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
