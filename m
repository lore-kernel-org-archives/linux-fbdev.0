From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 13/41] hecubafb: Kill sparse warnings
Date: Wed, 25 Apr 2007 14:33:36 +0800
Message-ID: <462EF640.3000106@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc6Q-0000xj-ID for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:39:50 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc6Q-0002pB-8j
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:39:50 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:39:50 -0700 (PDT)
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

The framebuffer memory is allocated from system RAM (vmalloc'ed).  Add __force
annotations.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/hecubafb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index ea5a6c9..dc12e2d 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -214,7 +214,7 @@ static void apollo_send_command(struct h
 static void hecubafb_dpy_update(struct hecubafb_par *par)
 {
 	int i;
-	unsigned char *buf = par->info->screen_base;
+	unsigned char *buf = (unsigned char __force *)par->info->screen_base;
 
 	apollo_send_command(par, 0xA0);
 
@@ -303,7 +303,7 @@ static ssize_t hecubafb_write(struct fil
 	if (count) {
 		char *base_addr;
 
-		base_addr = info->screen_base;
+		base_addr = (char __force *)info->screen_base;
 		count -= copy_from_user(base_addr + p, buf, count);
 		*ppos += count;
 		err = -EFAULT;
@@ -409,7 +409,7 @@ static int __devexit hecubafb_remove(str
 	if (info) {
 		fb_deferred_io_cleanup(info);
 		unregister_framebuffer(info);
-		vfree(info->screen_base);
+		vfree((void __force *)info->screen_base);
 		framebuffer_release(info);
 	}
 	return 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
