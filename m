From: Antonino Daplas <adaplas@pol.net>
Subject: Module unloading
Date: 03 Nov 2002 05:33:42 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1036272762.642.5.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1885wV-0005EB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 02 Nov 2002 13:36:31 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi James,

Regarding your latest patch, if the framebuffer console is not defined,
then the module_use_count should not be incremented and the device
should not be opened.  This will prevent the module from being unloaded.

Attached is a patch against 2.5.45 + your fbdev.diff.

Tony

diff -Naur linux-2.5.45-fbdev/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.45-fbdev/drivers/video/fbmem.c	Sat Nov  2 21:21:06 2002
+++ linux/drivers/video/fbmem.c	Sat Nov  2 21:24:29 2002
@@ -726,8 +726,8 @@
 int
 register_framebuffer(struct fb_info *fb_info)
 {
-	static int fb_ever_opened[FB_MAX];
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
+	static int fb_ever_opened[FB_MAX];
 	static int first = 1;
 	int j;
 #endif
@@ -743,9 +743,9 @@
 	fb_info->node = mk_kdev(FB_MAJOR, i);
 	fb_info->currcon = -1;
 	registered_fb[i] = fb_info;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE
 	if (!fb_ever_opened[i]) {
 		struct module *owner = fb_info->fbops->owner;
-#ifdef CONFIG_FRAMEBUFFER_CONSOLE
 		/*
 		 *  We assume initial frame buffer devices can be opened this
 		 *  many times
@@ -767,14 +767,6 @@
 	if (first) {
 		first = 0;
 		take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
-	}
-#else
-		if (owner) {
-			__MOD_INC_USE_COUNT(owner);
-			if (fb_info->fbops->fb_open && fb_info->fbops->fb_open(fb_info,0))
-				__MOD_DEC_USE_COUNT(owner);
-		}
-		fb_ever_opened[i] = 1;
 	}
 #endif
 	sprintf (name_buf, "%d", i);





-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
