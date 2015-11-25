From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Wed, 25 Nov 2015 03:11:48 +0000
Subject: [PATCH RESEND] fbdev: Make fb-notify a no-op if CONFIG_FB=n
Message-Id: <1448421108-3437-1-git-send-email-ezequiel@vanguardiasur.com.ar>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

There's no point in having support for framebuffer notifications
is CONFIG_FB is disabled. This commit adds the necessary stubs
for code to link properly when CONFIG_FB=n and moves fb-notify.o
to be built only when CONFIG_FB=y.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/video/fbdev/Kconfig       |  4 ++++
 drivers/video/fbdev/core/Makefile |  2 +-
 include/linux/fb.h                | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e6d16d65e4e6..6d881260856e 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -5,6 +5,7 @@
 menuconfig FB
 	tristate "Support for frame buffer devices"
 	select FB_CMDLINE
+	select FB_NOTIFY
 	---help---
 	  The frame buffer device provides an abstraction for the graphics
 	  hardware. It represents the frame buffer of some video hardware and
@@ -56,6 +57,9 @@ config FIRMWARE_EDID
 config FB_CMDLINE
 	bool
 
+config FB_NOTIFY
+	bool
+
 config FB_DDC
        tristate
        depends on FB
diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 23d86a8b7d7b..9e3ddf225393 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -1,5 +1,5 @@
-obj-y                             += fb_notify.o
 obj-$(CONFIG_FB_CMDLINE)          += fb_cmdline.o
+obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
                                      modedb.o fbcvt.o
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3d003805aac3..55433f86f0a3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -175,9 +175,27 @@ struct fb_blit_caps {
 	u32 flags;
 };
 
+#ifdef CONFIG_FB_NOTIFY
 extern int fb_register_client(struct notifier_block *nb);
 extern int fb_unregister_client(struct notifier_block *nb);
 extern int fb_notifier_call_chain(unsigned long val, void *v);
+#else
+static inline int fb_register_client(struct notifier_block *nb)
+{
+	return 0;
+};
+
+static inline int fb_unregister_client(struct notifier_block *nb)
+{
+	return 0;
+};
+
+static inline int fb_notifier_call_chain(unsigned long val, void *v)
+{
+	return 0;
+};
+#endif
+
 /*
  * Pixmap structure definition
  *
-- 
2.6.2

