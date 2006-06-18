From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/9] VT binding: Do not create a device
 file for class device 'fbcon'
Date: Sun, 18 Jun 2006 23:26:02 +0800
Message-ID: <4495708A.70409@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FrzVN-0001tx-Uk for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:06 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrzVJ-0000XY-K8
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:05 -0700
Received: by py-out-1112.google.com with SMTP id i49so1055622pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 08:48:01 -0700 (PDT)
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
Cc: Greg KH <gregkh@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

The class device "fbcon" does not need to be a device file.  Do not create
one by passing a major and minor number of zero to
class_device_create()/destroy().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 839f414..6e813a1 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3244,9 +3244,7 @@ static int __init fb_console_init(void)
 	acquire_console_sem();
 	fb_register_client(&fbcon_event_notifier);
 	fbcon_class_device =
-	    class_device_create(fb_class, NULL,
-				MKDEV(FB_MAJOR, FB_MAX), NULL,
-				"fbcon");
+	    class_device_create(fb_class, NULL, MKDEV(0, 0), NULL, "fbcon");
 
 	if (IS_ERR(fbcon_class_device)) {
 		printk(KERN_WARNING "Unable to create class_device "
@@ -3282,7 +3280,7 @@ static void __exit fb_console_exit(void)
 	acquire_console_sem();
 	fb_unregister_client(&fbcon_event_notifier);
 	fbcon_deinit_class_device();
-	class_device_destroy(fb_class, MKDEV(FB_MAJOR, FB_MAX));
+	class_device_destroy(fb_class, MKDEV(0, 0));
 	fbcon_exit();
 	release_console_sem();
 	unregister_con_driver(&fb_con);
