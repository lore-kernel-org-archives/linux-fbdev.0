From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 19/20] pm2fb: Fix of jumps in pm2fb_probe
Date: Sat, 05 May 2007 23:06:02 +0800
Message-ID: <463C9D5A.7030409@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMcF-0002ga-42 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:56:11 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMEd-0008EN-7G
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:48 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:31:47 -0700 (PDT)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes incorrect targets of jumps when an error occurs
in the pm2fb_probe.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 7f4c753..1ac5264 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1335,10 +1335,10 @@ #endif
 		info->var = pm2fb_var;
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
-		goto err_exit_all;
+		goto err_exit_both;
 
 	if (register_framebuffer(info) < 0)
-		goto err_exit_both;
+		goto err_exit_all;
 
 	printk(KERN_INFO "fb%d: %s frame buffer device, memory = %dK.\n",
 	       info->node, info->fix.id, pm2fb_fix.smem_len / 1024);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
