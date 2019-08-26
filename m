From: Peter Rosin <peda@axentia.se>
Date: Mon, 26 Aug 2019 19:58:58 +0000
Subject: [PATCH v2 2/3] fbdev: fbmem: allow overriding the number of bootup logos
Message-Id: <20190826195740.29415-3-peda@axentia.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190826195740.29415-1-peda@axentia.se>
In-Reply-To: <20190826195740.29415-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>

Probably most useful if you only want one logo regardless of how many
CPU cores you have.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/fb/fbcon.rst       | 5 +++++
 drivers/video/fbdev/core/fbcon.c | 7 +++++++
 drivers/video/fbdev/core/fbmem.c | 4 +++-
 include/linux/fb.h               | 1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 65ba40255137..9f0b399d8d4e 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -174,6 +174,11 @@ C. Boot options
 	displayed due to multiple CPUs, the collected line of logos is moved
 	as a whole.
 
+9. fbcon=logo-count:<n>
+
+	The value 'n' overrides the number of bootup logos. Zero gives the
+	default, which is the number of online cpus.
+
 C. Attaching, Detaching and Unloading
 
 Before going on to how to attach, detach and unload the framebuffer console, an
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c9235a2f42f8..be4bc5540aad 100644
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
+				fb_logo_count = simple_strtoul(options, &options, 0);
+			continue;
+		}
 	}
 	return 1;
 }
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 64dd732021d8..a7d8022db516 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -56,6 +56,8 @@ EXPORT_SYMBOL(num_registered_fb);
 bool fb_center_logo __read_mostly;
 EXPORT_SYMBOL(fb_center_logo);
 
+unsigned int fb_logo_count __read_mostly;
+
 static struct fb_info *get_fb_info(unsigned int idx)
 {
 	struct fb_info *fb_info;
@@ -689,7 +691,7 @@ int fb_show_logo(struct fb_info *info, int rotate)
 	int y;
 
 	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0,
-			      num_online_cpus());
+			      fb_logo_count ?: num_online_cpus());
 	y = fb_show_extra_logos(info, y, rotate);
 
 	return y;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 303771264644..5f2b05406262 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -630,6 +630,7 @@ extern int fb_new_modelist(struct fb_info *info);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 extern bool fb_center_logo;
+extern unsigned int fb_logo_count;
 extern struct class *fb_class;
 
 #define for_each_registered_fb(i)		\
-- 
2.11.0
