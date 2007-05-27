From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/9] cfag12864bfb: Use sys_ instead of
	cfb_ framebuffer accessors
Date: Sun, 27 May 2007 08:48:07 +0800
Message-ID: <4658D547.8020707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsFPX-0001vT-5m for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:40 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsFPW-0003fW-UJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:39 -0700
Received: by py-out-1112.google.com with SMTP id u77so2302792pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 May 2007 02:51:38 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Miguel Ojeda Sandonis <maxextreme@gmail.com>, Avuton Olrich <avuton@gmail.com>

From: Avuton Olrich <avuton@gmail.com>

Because the framebuffer memory is allocated system RAM, use the sys_ drawing
libraries. It also fixes the following compile error:

  LD      .tmp_vmlinux1
drivers/built-in.o:(.data+0x8b48): undefined reference to `cfb_fillrect'
drivers/built-in.o:(.data+0x8b50): undefined reference to `cfb_copyarea'
drivers/built-in.o:(.data+0x8b58): undefined reference to `cfb_imageblit'

[adaplas]
Use fb_sys_read/write for the same reasons as above.

Signed-off-by: Avuton Olrich <avuton@gmail.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/auxdisplay/Kconfig        |    4 ++++
 drivers/auxdisplay/cfag12864bfb.c |    8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 7c2ef5c..0e09376 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -72,6 +72,10 @@ config CFAG12864B
 	depends on X86
 	depends on FB
 	depends on KS0108
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
 	default n
 	---help---
 	  If you have a Crystalfontz 128x64 2-color LCD, cfag12864b Series,
diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 66fafbb..307c190 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -73,9 +73,11 @@ static int cfag12864bfb_mmap(struct fb_i
 
 static struct fb_ops cfag12864bfb_ops = {
 	.owner = THIS_MODULE,
-	.fb_fillrect = cfb_fillrect,
-	.fb_copyarea = cfb_copyarea,
-	.fb_imageblit = cfb_imageblit,
+	.fb_read = fb_sys_read,
+	.fb_write = fb_sys_write,
+	.fb_fillrect = sys_fillrect,
+	.fb_copyarea = sys_copyarea,
+	.fb_imageblit = sys_imageblit,
 	.fb_mmap = cfag12864bfb_mmap,
 };
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
