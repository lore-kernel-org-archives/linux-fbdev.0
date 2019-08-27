From: Peter Rosin <peda@axentia.se>
Date: Tue, 27 Aug 2019 11:09:21 +0000
Subject: [PATCH v3 2/3] fbdev: fbmem: allow overriding the number of bootup logos
Message-Id: <20190827110854.12574-3-peda@axentia.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190827110854.12574-1-peda@axentia.se>
In-Reply-To: <20190827110854.12574-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

Probably most useful if you want no logo at all, or if you only want one
logo regardless of how many CPU cores you have.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/fb/fbcon.rst       |  5 +++++
 drivers/video/fbdev/core/fbcon.c |  7 +++++++
 drivers/video/fbdev/core/fbmem.c | 12 +++++++++---
 include/linux/fb.h               |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 65ba40255137..e57a3d1d085a 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -174,6 +174,11 @@ C. Boot options
 	displayed due to multiple CPUs, the collected line of logos is moved
 	as a whole.
 
+9. fbcon=logo-count:<n>
+
+	The value 'n' overrides the number of bootup logos. 0 disables the
+	logo, and -1 gives the default which is the number of online CPUs.
+
 C. Attaching, Detaching and Unloading
 
 Before going on to how to attach, detach and unload the framebuffer console, an
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c9235a2f42f8..bb6ae995c2e5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -536,6 +536,13 @@ static int __init fb_console_setup(char *this_opt)
 				fb_center_logo = true;
 			continue;
 		}
+
+		if (!strncmp(options, "logo-count:", 11)) {
+			options += 11;
+			if (*options)
+				fb_logo_count = simple_strtol(options, &options, 0);
+			continue;
+		}
 	}
 	return 1;
 }
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 64dd732021d8..c7ddcb72025b 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -56,6 +56,8 @@ EXPORT_SYMBOL(num_registered_fb);
 bool fb_center_logo __read_mostly;
 EXPORT_SYMBOL(fb_center_logo);
 
+int fb_logo_count __read_mostly = -1;
+
 static struct fb_info *get_fb_info(unsigned int idx)
 {
 	struct fb_info *fb_info;
@@ -620,7 +622,7 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
 	if (info->flags & FBINFO_MISC_TILEBLITTING ||
-	    info->fbops->owner)
+	    info->fbops->owner || !fb_logo_count)
 		return 0;
 
 	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
@@ -686,10 +688,14 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 
 int fb_show_logo(struct fb_info *info, int rotate)
 {
+	unsigned int count;
 	int y;
 
-	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0,
-			      num_online_cpus());
+	if (!fb_logo_count)
+		return 0;
+
+	count = fb_logo_count < 0 ? num_online_cpus() : fb_logo_count;
+	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0, count);
 	y = fb_show_extra_logos(info, y, rotate);
 
 	return y;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 303771264644..e37f72b2efca 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -630,6 +630,7 @@ extern int fb_new_modelist(struct fb_info *info);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 extern bool fb_center_logo;
+extern int fb_logo_count;
 extern struct class *fb_class;
 
 #define for_each_registered_fb(i)		\
-- 
2.11.0
