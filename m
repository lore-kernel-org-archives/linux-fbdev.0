From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/8] fbcon: Revise primary device
	selection
Date: Thu, 31 May 2007 21:02:34 +0800
Message-ID: <465EC76A.30307@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtkQN-0001IB-Gc for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:43 -0700
Received: from wx-out-0506.google.com ([66.249.82.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtkQN-0001YJ-4M
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:43 -0700
Received: by wx-out-0506.google.com with SMTP id t15so151309wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 06:10:42 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "David S. Miller" <davem@davemloft.net>

Use set_con2fb_map() to select the primary display driver instead of using
unbind_con_driver() and bind_con_driver().  Using the former is much simpler
and safer than the current one.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---
I was forced to use unbind_con_driver/bind_con_driver initially because
set_con2fb_map() is broken. Now that it is fixed, I can move primary device
selection to set_con2fb_map. There is lesser complexity and lesser code, and
it does not depend on the VT layer.

Tony

 drivers/video/console/Kconfig |    6 +----
 drivers/video/console/fbcon.c |   51 +++++++++++------------------------------
 2 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 1e11d30..449f92c 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -120,7 +120,7 @@ config FRAMEBUFFER_CONSOLE
 
 config FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
        bool "Map the console to the primary display device"
-       depends on FRAMEBUFFER_CONSOLE && VT_HW_CONSOLE_BINDING
+       depends on FRAMEBUFFER_CONSOLE
        default n
        ---help---
          If this option is selected, the framebuffer console will
@@ -132,10 +132,6 @@ config FRAMEBUFFER_CONSOLE_DETECT_PRIMAR
 	 You can always override the automatic selection of the primary device
 	 by using the fbcon=map: boot option.
 
-	 To select this feature, "Support for binding and unbinding console
-         drivers", under "Device Drivers"->"Character Devices" must be set to
-	 y.
-
 	 If unsure, select n.
 
 config FRAMEBUFFER_CONSOLE_ROTATION
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 13b67ee..51bd430 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3041,52 +3041,32 @@ static int fbcon_fb_unregistered(struct 
 }
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
-static int fbcon_select_primary(struct fb_info *info)
+static void fbcon_select_primary(struct fb_info *info)
 {
-	int ret = 0;
-
 	if (!map_override && primary_device == -1 &&
 	    fb_is_primary_device(info)) {
-		int i, err;
+		int i;
 
-		printk(KERN_INFO "fbcon: %s is primary device\n",
-		       info->fix.id);
+		printk(KERN_INFO "fbcon: %s (fb%i) is primary device\n",
+		       info->fix.id, info->node);
 		primary_device = info->node;
 
-		if (!con_is_bound(&fb_con))
-			goto done;
-
-		printk(KERN_INFO "fbcon: Unbinding old driver\n");
-		unbind_con_driver(&fb_con, first_fb_vc, last_fb_vc,
-				  fbcon_is_default);
-		info_idx = primary_device;
-
-		for (i = first_fb_vc; i <= last_fb_vc; i++) {
+		for (i = first_fb_vc; i <= last_fb_vc; i++)
 			con2fb_map_boot[i] = primary_device;
-			con2fb_map[i] = primary_device;
-		}
-
-		printk(KERN_INFO "fbcon: Selecting new driver\n");
-		err = bind_con_driver(&fb_con, first_fb_vc, last_fb_vc,
-				      fbcon_is_default);
 
-		if (err) {
-			for (i = first_fb_vc; i <= last_fb_vc; i++)
-				con2fb_map[i] = -1;
-
-			info_idx = -1;
+		if (con_is_bound(&fb_con)) {
+			printk(KERN_INFO "fbcon: Remapping primary device, "
+			       "fb%i, to tty %i-%i\n", info->node,
+			       first_fb_vc + 1, last_fb_vc + 1);
+			info_idx = primary_device;
 		}
-
-		ret = 1;
 	}
-
-done:
-	return ret;
+	
 }
 #else
-static inline int fbcon_select_primary(struct fb_info *info)
+static inline void fbcon_select_primary(struct fb_info *info)
 {
-	return 0;
+	return;
 }
 #endif /* CONFIG_FRAMEBUFFER_DETECT_PRIMARY */
 
@@ -3094,9 +3074,7 @@ static int fbcon_fb_registered(struct fb
 {
 	int ret = 0, i, idx = info->node;
 
-	if (fbcon_select_primary(info))
-		goto done;
-
+	fbcon_select_primary(info);
 
 	if (info_idx == -1) {
 		for (i = first_fb_vc; i <= last_fb_vc; i++) {
@@ -3115,7 +3093,6 @@ static int fbcon_fb_registered(struct fb
 		}
 	}
 
-done:
 	return ret;
 }
 




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
