From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Sep 2014 16:00:33 +0000
Subject: [PATCH] videomode: provide dummy of_get_display_timing helper
Message-Id: <1957575.to7BPgiTer@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If CONFIG_OF is disabled but we build any driver that tries to
use of_get_display_timing, we get this link error:

ERROR: "of_get_display_timing" [drivers/gpu/drm/rcar-du/rcar-du-drm.ko] undefined!

This adds an empty inline function as an alternative, to avoid changing
each driver using this function when we want to build them without
CONFIG_OF.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/video/of_display_timing.h b/include/video/of_display_timing.h
index 79e6697af6cf..02b6eb7c3ded 100644
--- a/include/video/of_display_timing.h
+++ b/include/video/of_display_timing.h
@@ -15,8 +15,17 @@ struct display_timings;
 
 #define OF_USE_NATIVE_MODE -1
 
+#ifdef CONFIG_OF
 int of_get_display_timing(struct device_node *np, const char *name,
 		struct display_timing *dt);
+#else
+static inline int of_get_display_timing(struct device_node *np, const char *name,
+		struct display_timing *dt)
+{
+	return -ENOSYS;
+}
+
+#endif
 struct display_timings *of_get_display_timings(struct device_node *np);
 int of_display_timings_exist(struct device_node *np);
 

