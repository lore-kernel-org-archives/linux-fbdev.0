From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 30 Aug 2018 21:00:05 +0000
Subject: [PATCH v2 02/12] fbdev: allow apertures == NULL in remove_conflicting_framebuffers()
Message-Id: <7e3a48e397298b38d7ddc7f45d48226d1f5db3e4.1535656077.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org

Interpret (otherwise-invalid) NULL apertures argument to mean all-memory
range. This will allow to remove several duplicates of this code from
drivers in following patches.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
[for v1]
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

---
v2: added kerneldoc to corresponding DRM helper
---
 drivers/video/fbdev/core/fbmem.c | 14 ++++++++++++++
 include/drm/drm_fb_helper.h      | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 30a18d4c9de4..0df148eb4699 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1779,11 +1779,25 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 				    const char *name, bool primary)
 {
 	int ret;
+	bool do_free = false;
+
+	if (!a) {
+		a = alloc_apertures(1);
+		if (!a)
+			return -ENOMEM;
+
+		a->ranges[0].base = 0;
+		a->ranges[0].size = ~0;
+		do_free = true;
+	}
 
 	mutex_lock(&registration_lock);
 	ret = do_remove_conflicting_framebuffers(a, name, primary);
 	mutex_unlock(&registration_lock);
 
+	if (do_free)
+		kfree(a);
+
 	return ret;
 }
 EXPORT_SYMBOL(remove_conflicting_framebuffers);
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index b069433e7fc1..1c1e53abb25d 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -566,6 +566,16 @@ static inline void drm_fb_helper_output_poll_changed(struct drm_device *dev)
 
 #endif
 
+/**
+ * drm_fb_helper_remove_conflicting_framebuffers - remove firmware framebuffers
+ * @a: memory range, users of which are to be removed
+ * @name: requesting driver name
+ * @primary: also kick vga16fb if present
+ *
+ * This function removes framebuffer devices (eg. initialized by firmware)
+ * which use memory range described by @a. If @a is NULL all such devices are
+ * removed.
+ */
 static inline int
 drm_fb_helper_remove_conflicting_framebuffers(struct apertures_struct *a,
 					      const char *name, bool primary)
-- 
2.18.0
