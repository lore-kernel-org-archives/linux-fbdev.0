From: Joe Perches <joe@perches.com>
Date: Fri, 20 Sep 2013 01:35:54 +0000
Subject: [PATCH 1/2] framebuffer: Add fb_<level> convenience logging macros
Message-Id: <0926c7a34ac51c4cbb67debd0d883f41891e75d9.1379640011.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Add fb_<level> convenience macros for emitting the
"fb%d: ", struct fb_info->node value.

Neatens and shortens the code a bit.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/fb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index ffac70a..70c4836 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -792,4 +792,16 @@ extern int fb_find_mode(struct fb_var_screeninfo *var,
 			const struct fb_videomode *default_mode,
 			unsigned int default_bpp);
 
+/* Convenience logging macros */
+#define fb_err(fb_info, fmt, ...)					\
+	pr_err("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
+#define fb_notice(info, fmt, ...)					\
+	pr_notice("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
+#define fb_warn(fb_info, fmt, ...)					\
+	pr_warn("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
+#define fb_info(fb_info, fmt, ...)					\
+	pr_info("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
+#define fb_dbg(fb_info, fmt, ...)					\
+	pr_debug("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
+
 #endif /* _LINUX_FB_H */
-- 
1.8.1.2.459.gbcd45b4.dirty

