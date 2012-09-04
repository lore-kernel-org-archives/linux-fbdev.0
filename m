From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 04 Sep 2012 01:35:23 +0000
Subject: [PATCH] fbdev: move EXPORT_SYMBOL statements to the functions
Message-Id: <000e01cd8a3d$8daff6d0$a90fe470$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch moves the EXPORT_SYMBOL statements to the functions
they belong to.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/fbcmap.c |   17 +++++------------
 drivers/video/fbcvt.c  |    1 +
 drivers/video/fbmem.c  |   26 ++++++++++++++------------
 drivers/video/fbmon.c  |   22 +++++++++++++++-------
 drivers/video/modedb.c |   20 +++++++++-----------
 5 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index 5c3960d..8b25bcd 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -132,6 +132,7 @@ int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp)
 {
 	return fb_alloc_cmap_gfp(cmap, len, transp, GFP_ATOMIC);
 }
+EXPORT_SYMBOL(fb_alloc_cmap);
 
 /**
  *      fb_dealloc_cmap - deallocate a colormap
@@ -152,6 +153,7 @@ void fb_dealloc_cmap(struct fb_cmap *cmap)
 	cmap->red = cmap->green = cmap->blue = cmap->transp = NULL;
 	cmap->len = 0;
 }
+EXPORT_SYMBOL(fb_dealloc_cmap);
 
 /**
  *	fb_copy_cmap - copy a colormap
@@ -184,6 +186,7 @@ int fb_copy_cmap(const struct fb_cmap *from, struct fb_cmap *to)
 		memcpy(to->transp+tooff, from->transp+fromoff, size);
 	return 0;
 }
+EXPORT_SYMBOL(fb_copy_cmap);
 
 int fb_cmap_to_user(const struct fb_cmap *from, struct fb_cmap_user *to)
 {
@@ -259,6 +262,7 @@ int fb_set_cmap(struct fb_cmap *cmap, struct fb_info *info)
 
 	return rc;
 }
+EXPORT_SYMBOL(fb_set_cmap);
 
 int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 {
@@ -319,7 +323,7 @@ const struct fb_cmap *fb_default_cmap(int len)
 	return &default_8_colors;
     return &default_16_colors;
 }
-
+EXPORT_SYMBOL(fb_default_cmap);
 
 /**
  *	fb_invert_cmaps - invert all defaults colormaps
@@ -353,15 +357,4 @@ void fb_invert_cmaps(void)
 	blue16[i] = ~blue16[i];
     }
 }
-
-
-    /*
-     *  Visible symbols for modules
-     */
-
-EXPORT_SYMBOL(fb_alloc_cmap);
-EXPORT_SYMBOL(fb_dealloc_cmap);
-EXPORT_SYMBOL(fb_copy_cmap);
-EXPORT_SYMBOL(fb_set_cmap);
-EXPORT_SYMBOL(fb_default_cmap);
 EXPORT_SYMBOL(fb_invert_cmaps);
diff --git a/drivers/video/fbcvt.c b/drivers/video/fbcvt.c
index 7cb715d..319b5c4 100644
--- a/drivers/video/fbcvt.c
+++ b/drivers/video/fbcvt.c
@@ -377,3 +377,4 @@ int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb)
 
 	return 0;
 }
+EXPORT_SYMBOL(fb_find_mode_cvt);
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 3ff0105..e11ac80 100644
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
 
@@ -665,9 +670,11 @@ int fb_show_logo(struct fb_info *info, int rotate)
 
 	return y;
 }
+EXPORT_SYMBOL(fb_show_logo);
 #else
 int fb_prepare_logo(struct fb_info *info, int rotate) { return 0; }
 int fb_show_logo(struct fb_info *info, int rotate) { return 0; }
+EXPORT_SYMBOL(fb_show_logo);
 #endif /* CONFIG_LOGO */
 
 static void *fb_seq_start(struct seq_file *m, loff_t *pos)
@@ -909,6 +916,7 @@ fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 		info->var.vmode &= ~FB_VMODE_YWRAP;
 	return 0;
 }
+EXPORT_SYMBOL(fb_pan_display);
 
 static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
 			 u32 activate)
@@ -1042,6 +1050,7 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
  done:
 	return ret;
 }
+EXPORT_SYMBOL(fb_set_var);
 
 int
 fb_blank(struct fb_info *info, int blank)
@@ -1073,6 +1082,7 @@ fb_blank(struct fb_info *info, int blank)
 
  	return ret;
 }
+EXPORT_SYMBOL(fb_blank);
 
 static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
@@ -1734,6 +1744,7 @@ register_framebuffer(struct fb_info *fb_info)
 
 	return ret;
 }
+EXPORT_SYMBOL(register_framebuffer);
 
 /**
  *	unregister_framebuffer - releases a frame buffer device
@@ -1762,6 +1773,7 @@ unregister_framebuffer(struct fb_info *fb_info)
 
 	return ret;
 }
+EXPORT_SYMBOL(unregister_framebuffer);
 
 /**
  *	fb_set_suspend - low level driver signals suspend
@@ -1785,6 +1797,7 @@ void fb_set_suspend(struct fb_info *info, int state)
 		fb_notifier_call_chain(FB_EVENT_RESUME, &event);
 	}
 }
+EXPORT_SYMBOL(fb_set_suspend);
 
 /**
  *	fbmem_init - init frame buffer subsystem
@@ -1904,6 +1917,7 @@ int fb_get_options(char *name, char **option)
 
 	return retval;
 }
+EXPORT_SYMBOL(fb_get_options);
 
 #ifndef MODULE
 /**
@@ -1955,16 +1969,4 @@ __setup("video=", video_setup);
      *  Visible symbols for modules
      */
 
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
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index cef6557..9af9202 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -675,6 +675,7 @@ void fb_destroy_modedb(struct fb_videomode *modedb)
 {
 	kfree(modedb);
 }
+EXPORT_SYMBOL(fb_destroy_modedb);
 
 static int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
 {
@@ -917,6 +918,7 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 	}
 	return 1;
 }
+EXPORT_SYMBOL(fb_parse_edid);
 
 void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
@@ -981,6 +983,7 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 
 	DPRINTK("====================\n");
 }
+EXPORT_SYMBOL(fb_edid_to_monspecs);
 
 /**
  * fb_edid_add_monspecs() - add monitor video modes from E-EDID data
@@ -1065,6 +1068,7 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	specs->modedb = m;
 	specs->modedb_len = specs->modedb_len + num + svd_n;
 }
+EXPORT_SYMBOL(fb_edid_add_monspecs);
 
 /*
  * VESA Generalized Timing Formula (GTF)
@@ -1373,26 +1377,36 @@ int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_inf
 	kfree(timings);
 	return err;
 }
+EXPORT_SYMBOL(fb_get_mode);
 #else
 int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 {
 	return 1;
 }
+EXPORT_SYMBOL(fb_parse_edid);
+
 void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
 	specs = NULL;
 }
+EXPORT_SYMBOL(fb_edid_to_monspecs);
+
 void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
 }
+EXPORT_SYMBOL(fb_edid_add_monspecs);
+
 void fb_destroy_modedb(struct fb_videomode *modedb)
 {
 }
+EXPORT_SYMBOL(fb_destroy_modedb);
+
 int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
 		struct fb_info *info)
 {
 	return -EINVAL;
 }
+EXPORT_SYMBOL(fb_get_mode);
 #endif /* CONFIG_FB_MODE_HELPERS */
 
 /*
@@ -1457,6 +1471,7 @@ int fb_validate_mode(const struct fb_var_screeninfo *var, struct fb_info *info)
 		pixclock < dclkmin || pixclock > dclkmax) ?
 		-EINVAL : 0;
 }
+EXPORT_SYMBOL(fb_validate_mode);
 
 #if defined(CONFIG_FIRMWARE_EDID) && defined(CONFIG_X86)
 
@@ -1489,10 +1504,3 @@ const unsigned char *fb_firmware_edid(struct device *device)
 }
 #endif
 EXPORT_SYMBOL(fb_firmware_edid);
-
-EXPORT_SYMBOL(fb_parse_edid);
-EXPORT_SYMBOL(fb_edid_to_monspecs);
-EXPORT_SYMBOL(fb_edid_add_monspecs);
-EXPORT_SYMBOL(fb_get_mode);
-EXPORT_SYMBOL(fb_validate_mode);
-EXPORT_SYMBOL(fb_destroy_modedb);
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index a9a907c..b803677 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -765,6 +765,7 @@ done:
 	DPRINTK("No valid mode found\n");
 	return 0;
 }
+EXPORT_SYMBOL(fb_find_mode);
 
 /**
  * fb_var_to_videomode - convert fb_var_screeninfo to fb_videomode
@@ -809,6 +810,7 @@ void fb_var_to_videomode(struct fb_videomode *mode,
 	hfreq = pixclock/htotal;
 	mode->refresh = hfreq/vtotal;
 }
+EXPORT_SYMBOL(fb_var_to_videomode);
 
 /**
  * fb_videomode_to_var - convert fb_videomode to fb_var_screeninfo
@@ -834,6 +836,7 @@ void fb_videomode_to_var(struct fb_var_screeninfo *var,
 	var->sync = mode->sync;
 	var->vmode = mode->vmode & FB_VMODE_MASK;
 }
+EXPORT_SYMBOL(fb_videomode_to_var);
 
 /**
  * fb_mode_is_equal - compare 2 videomodes
@@ -858,6 +861,7 @@ int fb_mode_is_equal(const struct fb_videomode *mode1,
 		mode1->sync         = mode2->sync &&
 		mode1->vmode        = mode2->vmode);
 }
+EXPORT_SYMBOL(fb_mode_is_equal);
 
 /**
  * fb_find_best_mode - find best matching videomode
@@ -903,6 +907,7 @@ const struct fb_videomode *fb_find_best_mode(const struct fb_var_screeninfo *var
 	}
 	return best;
 }
+EXPORT_SYMBOL(fb_find_best_mode);
 
 /**
  * fb_find_nearest_mode - find closest videomode
@@ -945,6 +950,7 @@ const struct fb_videomode *fb_find_nearest_mode(const struct fb_videomode *mode,
 
 	return best;
 }
+EXPORT_SYMBOL(fb_find_nearest_mode);
 
 /**
  * fb_match_mode - find a videomode which exactly matches the timings in var
@@ -970,6 +976,7 @@ const struct fb_videomode *fb_match_mode(const struct fb_var_screeninfo *var,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(fb_match_mode);
 
 /**
  * fb_add_videomode - adds videomode entry to modelist
@@ -1005,6 +1012,7 @@ int fb_add_videomode(const struct fb_videomode *mode, struct list_head *head)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(fb_add_videomode);
 
 /**
  * fb_delete_videomode - removed videomode entry from modelist
@@ -1064,6 +1072,7 @@ void fb_videomode_to_modelist(const struct fb_videomode *modedb, int num,
 			return;
 	}
 }
+EXPORT_SYMBOL(fb_videomode_to_modelist);
 
 const struct fb_videomode *fb_find_best_display(const struct fb_monspecs *specs,
 					        struct list_head *head)
@@ -1124,14 +1133,3 @@ finished:
 	return best;
 }
 EXPORT_SYMBOL(fb_find_best_display);
-
-EXPORT_SYMBOL(fb_videomode_to_var);
-EXPORT_SYMBOL(fb_var_to_videomode);
-EXPORT_SYMBOL(fb_mode_is_equal);
-EXPORT_SYMBOL(fb_add_videomode);
-EXPORT_SYMBOL(fb_match_mode);
-EXPORT_SYMBOL(fb_find_best_mode);
-EXPORT_SYMBOL(fb_find_nearest_mode);
-EXPORT_SYMBOL(fb_videomode_to_modelist);
-EXPORT_SYMBOL(fb_find_mode);
-EXPORT_SYMBOL(fb_find_mode_cvt);
-- 
1.7.1


