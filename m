From: akpm@osdl.org
Subject: [patch 1/3] fbdev compat_ioctl warning fix
Date: Wed, 09 Feb 2005 22:33:10 -0800
Message-ID: <200502100633.j1A6XCl31945@mail.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cz7t6-0006H4-Sl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Feb 2005 22:33:16 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cz7t5-0001gk-AM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Feb 2005 22:33:16 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org



Fix some confusion over fbdev compat_ioctl return types - compat_ioctls return
`long'.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/video/fbmem.c |    3 ++-
 25-akpm/include/linux/fb.h    |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/video/sis/sis_main.c~sisfb_compat_ioctl-warning-fix drivers/video/sis/sis_main.c
diff -puN include/linux/fb.h~sisfb_compat_ioctl-warning-fix include/linux/fb.h
--- 25/include/linux/fb.h~sisfb_compat_ioctl-warning-fix	2005-02-09 22:24:52.000000000 -0800
+++ 25-akpm/include/linux/fb.h	2005-02-09 22:24:57.000000000 -0800
@@ -585,7 +585,7 @@ struct fb_ops {
 			unsigned long arg, struct fb_info *info);
 
 	/* Handle 32bit compat ioctl (optional) */
-	int (*fb_compat_ioctl)(struct file *f, unsigned cmd, unsigned long arg,
+	long (*fb_compat_ioctl)(struct file *f, unsigned cmd, unsigned long arg,
 			       struct fb_info *info);
 
 	/* perform fb specific mmap */
diff -puN drivers/video/fbmem.c~sisfb_compat_ioctl-warning-fix drivers/video/fbmem.c
--- 25/drivers/video/fbmem.c~sisfb_compat_ioctl-warning-fix	2005-02-09 22:26:18.000000000 -0800
+++ 25-akpm/drivers/video/fbmem.c	2005-02-09 22:26:34.000000000 -0800
@@ -876,7 +876,8 @@ fb_compat_ioctl(struct file *file, unsig
 	int fbidx = iminor(file->f_dentry->d_inode);
 	struct fb_info *info = registered_fb[fbidx];
 	struct fb_ops *fb = info->fbops;
-	int ret;
+	long ret;
+
 	if (fb->fb_compat_ioctl == NULL)
 		return -ENOIOCTLCMD;
 	lock_kernel();
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
