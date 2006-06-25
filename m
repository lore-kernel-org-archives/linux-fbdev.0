From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbcon: Fix module ref counting
Date: Sun, 25 Jun 2006 18:05:41 +0800
Message-ID: <449E5FF5.7020600@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuRaQ-00067i-La for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:11:26 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FuRaQ-0002vC-B7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:11:26 -0700
Received: by py-out-1112.google.com with SMTP id s49so1239693pyc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Jun 2006 03:11:26 -0700 (PDT)
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

fbcon may decrement the module ref count of drivers to < 0 when unloading.
This is because fbcon_exit() is called more than once (once on unbind, and
another on module unload).

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 6e813a1..5dc4083 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1213,7 +1213,7 @@ static void fbcon_deinit(struct vc_data 
 	ops->flags &= ~FBCON_FLAGS_INIT;
 finished:
 
-	if (!con_is_bound(&fb_con) && !fbcon_has_exited)
+	if (!con_is_bound(&fb_con))
 		fbcon_exit();
 
 	return;
@@ -3195,6 +3195,9 @@ static void fbcon_exit(void)
 	struct fb_info *info;
 	int i, j, mapped;
 
+	if (fbcon_has_exited)
+		return;
+
 #ifdef CONFIG_ATARI
 	free_irq(IRQ_AUTO_4, fbcon_vbl_handler);
 #endif


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
