From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 06 Aug 2014 12:05:34 +0000
Subject: [PATCH] video/fbdev: Always built-in video= cmdline parsing
Message-Id: <1407326734-30834-1-git-send-email-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407312512-6533-1-git-send-email-daniel.vetter@ffwll.ch>
In-Reply-To: <1407312512-6533-1-git-send-email-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

In drm/i915 we want to get at the video= cmdline modes even when we
don't have fbdev support enabled, so that users can always override
the kernel's initial mode selection.

But that gives us a direct depency upon the parsing code in the fbdev
subsystem. Since it's so little code just extract these 2 functions
and always build them in.

Whiel at it fix the checkpatch fail in this code.

v2: Also move fb_mode_option. Spotted by the kbuild.

Cc: Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>

--

I prefer if we can merge this through drm-next since we'll use it
there in follow-up patches.
-Daniel
---
 drivers/video/fbdev/core/Makefile     |   2 +-
 drivers/video/fbdev/core/fb_cmdline.c | 106 ++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c      |  92 -----------------------------
 drivers/video/fbdev/core/modedb.c     |   3 -
 4 files changed, 107 insertions(+), 96 deletions(-)
 create mode 100644 drivers/video/fbdev/core/fb_cmdline.c

diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index fa306538dac2..891c1f890e03 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -1,4 +1,4 @@
-obj-y                             += fb_notify.o
+obj-y                             += fb_notify.o fb_cmdline.o
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
                                      modedb.o fbcvt.o
diff --git a/drivers/video/fbdev/core/fb_cmdline.c b/drivers/video/fbdev/core/fb_cmdline.c
new file mode 100644
index 000000000000..e8ce614bdd03
--- /dev/null
+++ b/drivers/video/fbdev/core/fb_cmdline.c
@@ -0,0 +1,106 @@
+/*
+ *  linux/drivers/video/fb_cmdline.c
+ *
+ *  Copyright (C) 2014 Intel Corp
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ *
+ * Authors:
+ *    Vetter <danie.vetter@ffwll.ch>
+ */
+#include <linux/init.h>
+#include <linux/fb.h>
+
+static char *video_options[FB_MAX] __read_mostly;
+static int ofonly __read_mostly;
+
+const char *fb_mode_option;
+EXPORT_SYMBOL_GPL(fb_mode_option);
+
+/**
+ * fb_get_options - get kernel boot parameters
+ * @name:   framebuffer name as it would appear in
+ *          the boot parameter line
+ *          (video=<name>:<options>)
+ * @option: the option will be stored here
+ *
+ * NOTE: Needed to maintain backwards compatibility
+ */
+int fb_get_options(const char *name, char **option)
+{
+	char *opt, *options = NULL;
+	int retval = 0;
+	int name_len = strlen(name), i;
+
+	if (name_len && ofonly && strncmp(name, "offb", 4))
+		retval = 1;
+
+	if (name_len && !retval) {
+		for (i = 0; i < FB_MAX; i++) {
+			if (video_options[i] = NULL)
+				continue;
+			if (!video_options[i][0])
+				continue;
+			opt = video_options[i];
+			if (!strncmp(name, opt, name_len) &&
+			    opt[name_len] = ':')
+				options = opt + name_len + 1;
+		}
+	}
+	/* No match, pass global option */
+	if (!options && option && fb_mode_option)
+		options = kstrdup(fb_mode_option, GFP_KERNEL);
+	if (options && !strncmp(options, "off", 3))
+		retval = 1;
+
+	if (option)
+		*option = options;
+
+	return retval;
+}
+EXPORT_SYMBOL(fb_get_options);
+
+/**
+ *	video_setup - process command line options
+ *	@options: string of options
+ *
+ *	Process command line options for frame buffer subsystem.
+ *
+ *	NOTE: This function is a __setup and __init function.
+ *            It only stores the options.  Drivers have to call
+ *            fb_get_options() as necessary.
+ *
+ *	Returns zero.
+ *
+ */
+static int __init video_setup(char *options)
+{
+	int i, global = 0;
+
+	if (!options || !*options)
+		global = 1;
+
+	if (!global && !strncmp(options, "ofonly", 6)) {
+		ofonly = 1;
+		global = 1;
+	}
+
+	if (!global && !strchr(options, ':')) {
+		fb_mode_option = options;
+		global = 1;
+	}
+
+	if (!global) {
+		for (i = 0; i < FB_MAX; i++) {
+			if (video_options[i] = NULL) {
+				video_options[i] = options;
+				break;
+			}
+		}
+	}
+
+	return 1;
+}
+__setup("video=", video_setup);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index b5e85f6c1c26..0705d8883ede 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1908,96 +1908,4 @@ int fb_new_modelist(struct fb_info *info)
 	return err;
 }
 
-static char *video_options[FB_MAX] __read_mostly;
-static int ofonly __read_mostly;
-
-/**
- * fb_get_options - get kernel boot parameters
- * @name:   framebuffer name as it would appear in
- *          the boot parameter line
- *          (video=<name>:<options>)
- * @option: the option will be stored here
- *
- * NOTE: Needed to maintain backwards compatibility
- */
-int fb_get_options(const char *name, char **option)
-{
-	char *opt, *options = NULL;
-	int retval = 0;
-	int name_len = strlen(name), i;
-
-	if (name_len && ofonly && strncmp(name, "offb", 4))
-		retval = 1;
-
-	if (name_len && !retval) {
-		for (i = 0; i < FB_MAX; i++) {
-			if (video_options[i] = NULL)
-				continue;
-			if (!video_options[i][0])
-				continue;
-			opt = video_options[i];
-			if (!strncmp(name, opt, name_len) &&
-			    opt[name_len] = ':')
-				options = opt + name_len + 1;
-		}
-	}
-	/* No match, pass global option */
-	if (!options && option && fb_mode_option)
-		options = kstrdup(fb_mode_option, GFP_KERNEL);
-	if (options && !strncmp(options, "off", 3))
-		retval = 1;
-
-	if (option)
-		*option = options;
-
-	return retval;
-}
-EXPORT_SYMBOL(fb_get_options);
-
-#ifndef MODULE
-/**
- *	video_setup - process command line options
- *	@options: string of options
- *
- *	Process command line options for frame buffer subsystem.
- *
- *	NOTE: This function is a __setup and __init function.
- *            It only stores the options.  Drivers have to call
- *            fb_get_options() as necessary.
- *
- *	Returns zero.
- *
- */
-static int __init video_setup(char *options)
-{
-	int i, global = 0;
-
-	if (!options || !*options)
- 		global = 1;
-
- 	if (!global && !strncmp(options, "ofonly", 6)) {
- 		ofonly = 1;
- 		global = 1;
- 	}
-
- 	if (!global && !strchr(options, ':')) {
- 		fb_mode_option = options;
- 		global = 1;
- 	}
-
- 	if (!global) {
- 		for (i = 0; i < FB_MAX; i++) {
- 			if (video_options[i] = NULL) {
- 				video_options[i] = options;
- 				break;
- 			}
-
-		}
-	}
-
-	return 1;
-}
-__setup("video=", video_setup);
-#endif
-
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index a9a907c440d7..388f7971494b 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -29,9 +29,6 @@
 #define DPRINTK(fmt, args...)
 #endif
 
-const char *fb_mode_option;
-EXPORT_SYMBOL_GPL(fb_mode_option);
-
 /*
  *  Standard video mode definitions (taken from XFree86)
  */
-- 
2.0.1

