From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/9] fbcon: Allow fbcon to use the
	primary display driver
Date: Sun, 27 May 2007 09:03:30 +0800
Message-ID: <4658D8E2.3020608@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsFPt-0001vq-ID for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:52:02 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsFPt-0003fW-1i
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:52:01 -0700
Received: by py-out-1112.google.com with SMTP id u77so2302792pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 May 2007 02:52:00 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

Allow fbcon to select the primary display adapter using the
fb_is_primary_device() arch-specific helper.  If a a primary adapter is
detected, fbcon will unbind the old adapter from the VT layer, then rebind
using the new adapter. This requires that bind_/unbind_con_driver() be made
public.

Because this feature may produce unexpected behavior (from the user's POV),
this must be explicitly enabled in Kconfig.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 arch/i386/video/fbdev.c       |    4 +-
 drivers/char/vt.c             |    6 +--
 drivers/video/console/Kconfig |   20 ++++++++++
 drivers/video/console/fbcon.c |   80 +++++++++++++++++++++++++++++++++++++----
 include/linux/vt_kern.h       |    4 ++
 5 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/arch/i386/video/fbdev.c b/arch/i386/video/fbdev.c
index 7fc712c..48fb38d 100644
--- a/arch/i386/video/fbdev.c
+++ b/arch/i386/video/fbdev.c
@@ -13,13 +13,11 @@ #include <linux/pci.h>
 
 int fb_is_primary_device(struct fb_info *info)
 {
-	struct device *device;
+	struct device *device = info->device;
 	struct pci_dev *pci_dev = NULL;
 	struct resource *res = NULL;
 	int retval = 0;
 
-	device = info->device;
-
 	if (device)
 		pci_dev = to_pci_dev(device);
 
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index bbd9fc4..45baf04 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2863,8 +2863,7 @@ #include <linux/device.h>
 
 static struct class *vtconsole_class;
 
-static int bind_con_driver(const struct consw *csw, int first, int last,
-			   int deflt)
+int bind_con_driver(const struct consw *csw, int first, int last, int deflt)
 {
 	struct module *owner = csw->owner;
 	const char *desc = NULL;
@@ -2981,8 +2980,7 @@ static int con_is_graphics(const struct 
 	return retval;
 }
 
-static int unbind_con_driver(const struct consw *csw, int first, int last,
-			     int deflt)
+int unbind_con_driver(const struct consw *csw, int first, int last, int deflt)
 {
 	struct module *owner = csw->owner;
 	const struct consw *defcsw = NULL;
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 63b85bf..1e11d30 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -118,6 +118,26 @@ config FRAMEBUFFER_CONSOLE
 	help
 	  Low-level framebuffer-based console driver.
 
+config FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
+       bool "Map the console to the primary display device"
+       depends on FRAMEBUFFER_CONSOLE && VT_HW_CONSOLE_BINDING
+       default n
+       ---help---
+         If this option is selected, the framebuffer console will
+         automatically select the primary display device (if the architecture
+	 supports this feature).  Otherwise, the framebuffer console will
+         always select the first framebuffer driver that is loaded. The latter
+         is the default behavior.
+
+	 You can always override the automatic selection of the primary device
+	 by using the fbcon=map: boot option.
+
+	 To select this feature, "Support for binding and unbinding console
+         drivers", under "Device Drivers"->"Character Devices" must be set to
+	 y.
+
+	 If unsure, select n.
+
 config FRAMEBUFFER_CONSOLE_ROTATION
        bool "Framebuffer Console Rotation"
        depends on FRAMEBUFFER_CONSOLE
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 7f4ed79..7ba21eb 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -75,6 +75,7 @@ #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/crc32.h> /* For counting font checksums */
+#include <asm/fb.h>
 #include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -125,6 +126,8 @@ static int first_fb_vc;
 static int last_fb_vc = MAX_NR_CONSOLES - 1;
 static int fbcon_is_default = 1; 
 static int fbcon_has_exited;
+static int primary_device = -1;
+static int map_override;
 
 /* font data */
 static char fontname[40];
@@ -497,13 +500,17 @@ static int __init fb_console_setup(char 
 		
 		if (!strncmp(options, "map:", 4)) {
 			options += 4;
-			if (*options)
+			if (*options) {
 				for (i = 0, j = 0; i < MAX_NR_CONSOLES; i++) {
 					if (!options[j])
 						j = 0;
 					con2fb_map_boot[i] =
 						(options[j++]-'0') % FB_MAX;
 				}
+
+				map_override = 1;
+			}
+
 			return 1;
 		}
 
@@ -3004,9 +3011,9 @@ static int fbcon_mode_deleted(struct fb_
 	return found;
 }
 
-static int fbcon_fb_unregistered(int idx)
+static int fbcon_fb_unregistered(struct fb_info *info)
 {
-	int i;
+	int i, idx = info->node;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] == idx)
@@ -3034,12 +3041,70 @@ static int fbcon_fb_unregistered(int idx
 	if (!num_registered_fb)
 		unregister_con_driver(&fb_con);
 
+
+	if (primary_device == idx)
+		primary_device = -1;
+
+	return 0;
+}
+
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
+static int fbcon_select_primary(struct fb_info *info)
+{
+	int ret = 0;
+
+	if (!map_override && primary_device == -1 &&
+	    fb_is_primary_device(info)) {
+		int i, err;
+
+		printk(KERN_INFO "fbcon: %s is primary device\n",
+		       info->fix.id);
+		primary_device = info->node;
+
+		if (!con_is_bound(&fb_con))
+			goto done;
+
+		printk(KERN_INFO "fbcon: Unbinding old driver\n");
+		unbind_con_driver(&fb_con, first_fb_vc, last_fb_vc,
+				  fbcon_is_default);
+		info_idx = primary_device;
+
+		for (i = first_fb_vc; i <= last_fb_vc; i++) {
+			con2fb_map_boot[i] = primary_device;
+			con2fb_map[i] = primary_device;
+		}
+
+		printk(KERN_INFO "fbcon: Selecting new driver\n");
+		err = bind_con_driver(&fb_con, first_fb_vc, last_fb_vc,
+				      fbcon_is_default);
+
+		if (err) {
+			for (i = first_fb_vc; i <= last_fb_vc; i++)
+				con2fb_map[i] = -1;
+
+			info_idx = -1;
+		}
+
+		ret = 1;
+	}
+
+done:
+	return ret;
+}
+#else
+static inline int fbcon_select_primary(struct fb_info *info)
+{
 	return 0;
 }
+#endif /* CONFIG_FRAMEBUFFER_DETECT_PRIMARY */
 
-static int fbcon_fb_registered(int idx)
+static int fbcon_fb_registered(struct fb_info *info)
 {
-	int ret = 0, i;
+	int ret = 0, i, idx = info->node;
+
+	if (fbcon_select_primary(info))
+		goto done;
+
 
 	if (info_idx == -1) {
 		for (i = first_fb_vc; i <= last_fb_vc; i++) {
@@ -3059,6 +3124,7 @@ static int fbcon_fb_registered(int idx)
 		}
 	}
 
+done:
 	return ret;
 }
 
@@ -3182,10 +3248,10 @@ static int fbcon_event_notify(struct not
 		ret = fbcon_mode_deleted(info, mode);
 		break;
 	case FB_EVENT_FB_REGISTERED:
-		ret = fbcon_fb_registered(info->node);
+		ret = fbcon_fb_registered(info);
 		break;
 	case FB_EVENT_FB_UNREGISTERED:
-		ret = fbcon_fb_unregistered(info->node);
+		ret = fbcon_fb_unregistered(info);
 		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		con2fb = event->data;
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index d961635..0d034d8 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -75,6 +75,10 @@ int con_copy_unimap(struct vc_data *dst_
 int vt_waitactive(int vt);
 void change_console(struct vc_data *new_vc);
 void reset_vc(struct vc_data *vc);
+extern int bind_con_driver(const struct consw *csw, int first, int last,
+			   int deflt);
+extern int unbind_con_driver(const struct consw *csw, int first, int last,
+			     int deflt);
 
 /*
  * vc_screen.c shares this temporary buffer with the console write code so that


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
