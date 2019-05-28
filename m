From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:35 +0000
Subject: [PATCH 04/33] vt: More locking checks
Message-Id: <20190528090304.9388-5-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Adam Borowski <kilobyte@angband.pl>, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, Martin Hostettler <textshell@uchuujin.de>, Mikulas Patocka <mpatocka@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>

I honestly have no idea what the subtle differences between
con_is_visible, con_is_fg (internal to vt.c) and con_is_bound are. But
it looks like both vc->vc_display_fg and con_driver_map are protected
by the console_lock, so probably better if we hold that when checking
this.

To do that I had to deinline the con_is_visible function.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Martin Hostettler <textshell@uchuujin.de>
Cc: Adam Borowski <kilobyte@angband.pl>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/tty/vt/vt.c            | 16 ++++++++++++++++
 include/linux/console_struct.h |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bc9813b14c58..a8988a085138 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3815,6 +3815,8 @@ int con_is_bound(const struct consw *csw)
 {
 	int i, bound = 0;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (con_driver_map[i] = csw) {
 			bound = 1;
@@ -3826,6 +3828,20 @@ int con_is_bound(const struct consw *csw)
 }
 EXPORT_SYMBOL(con_is_bound);
 
+/**
+ * con_is_visible - checks whether the current console is visible
+ * @vc: virtual console
+ *
+ * RETURNS: zero if not visible, nonzero if visible
+ */
+bool con_is_visible(const struct vc_data *vc)
+{
+	WARN_CONSOLE_UNLOCKED();
+
+	return *vc->vc_display_fg = vc;
+}
+EXPORT_SYMBOL(con_is_visible);
+
 /**
  * con_debug_enter - prepare the console for the kernel debugger
  * @sw: console driver
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index ed798e114663..24d4c16e3ae0 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -168,9 +168,6 @@ extern void vc_SAK(struct work_struct *work);
 
 #define CUR_DEFAULT CUR_UNDERLINE
 
-static inline bool con_is_visible(const struct vc_data *vc)
-{
-	return *vc->vc_display_fg = vc;
-}
+bool con_is_visible(const struct vc_data *vc);
 
 #endif /* _LINUX_CONSOLE_STRUCT_H */
-- 
2.20.1
