From: Daniel Mack <zonque@gmail.com>
Date: Thu, 15 Aug 2013 14:12:55 +0000
Subject: [PATCH] fbmem: move EXPORT_SYMBOL annotation next to symbol declarations
Message-Id: <1376575975-13215-1-git-send-email-zonque@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Just a cosmetic thing to bring that file in line with others in the
tree.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/video/fbmem.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 36e1fe2..dacaf74 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -43,8 +43,12 @@
 #define FBPIXMAPSIZE	(1024 * 8)
 
 static DEFINE_MUTEX(registration_lock);
+
 struct fb_info *registered_fb[FB_MAX] __read_mostly;
+EXPORT_SYMBOL(registered_fb);
+
 int num_registered_fb __read_mostly;
+EXPORT_SYMBOL(num_registered_fb);
 
 static struct fb_info *get_fb_info(unsigned int idx)
 {
@@ -182,6 +186,7 @@ char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size
 
 	return addr;
 }
+EXPORT_SYMBOL(fb_get_buffer_offset);
 
 #ifdef CONFIG_LOGO
 
@@ -669,6 +674,7 @@ int fb_show_logo(struct fb_info *info, int rotate)
 int fb_prepare_logo(struct fb_info *info, int rotate) { return 0; }
 int fb_show_logo(struct fb_info *info, int rotate) { return 0; }
 #endif /* CONFIG_LOGO */
+EXPORT_SYMBOL(fb_show_logo);
 
 static void *fb_seq_start(struct seq_file *m, loff_t *pos)
 {
@@ -909,6 +915,7 @@ fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 		info->var.vmode &= ~FB_VMODE_YWRAP;
 	return 0;
 }
+EXPORT_SYMBOL(fb_pan_display);
 
 static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
 			 u32 activate)
@@ -1042,6 +1049,7 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
  done:
 	return ret;
 }
+EXPORT_SYMBOL(fb_set_var);
 
 int
 fb_blank(struct fb_info *info, int blank)
@@ -1073,6 +1081,7 @@ fb_blank(struct fb_info *info, int blank)
 
  	return ret;
 }
+EXPORT_SYMBOL(fb_blank);
 
 static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
@@ -1745,6 +1754,7 @@ register_framebuffer(struct fb_info *fb_info)
 
 	return ret;
 }
+EXPORT_SYMBOL(register_framebuffer);
 
 /**
  *	unregister_framebuffer - releases a frame buffer device
@@ -1773,6 +1783,7 @@ unregister_framebuffer(struct fb_info *fb_info)
 
 	return ret;
 }
+EXPORT_SYMBOL(unregister_framebuffer);
 
 /**
  *	fb_set_suspend - low level driver signals suspend
@@ -1796,6 +1807,7 @@ void fb_set_suspend(struct fb_info *info, int state)
 		fb_notifier_call_chain(FB_EVENT_RESUME, &event);
 	}
 }
+EXPORT_SYMBOL(fb_set_suspend);
 
 /**
  *	fbmem_init - init frame buffer subsystem
@@ -1912,6 +1924,7 @@ int fb_get_options(const char *name, char **option)
 
 	return retval;
 }
+EXPORT_SYMBOL(fb_get_options);
 
 #ifndef MODULE
 /**
@@ -1959,20 +1972,4 @@ static int __init video_setup(char *options)
 __setup("video=", video_setup);
 #endif
 
-    /*
-     *  Visible symbols for modules
-     */
-
-EXPORT_SYMBOL(register_framebuffer);
-EXPORT_SYMBOL(unregister_framebuffer);
-EXPORT_SYMBOL(num_registered_fb);
-EXPORT_SYMBOL(registered_fb);
-EXPORT_SYMBOL(fb_show_logo);
-EXPORT_SYMBOL(fb_set_var);
-EXPORT_SYMBOL(fb_blank);
-EXPORT_SYMBOL(fb_pan_display);
-EXPORT_SYMBOL(fb_get_buffer_offset);
-EXPORT_SYMBOL(fb_set_suspend);
-EXPORT_SYMBOL(fb_get_options);
-
 MODULE_LICENSE("GPL");
-- 
1.8.3.1

