From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 04 Dec 2017 22:33:21 +0000
Subject: [PATCH] drm: Document that drm_panel_orientation_quirks.c is shared with fbdev
Message-Id: <20171204223321.15799-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Add a comment to the DRM_PANEL_ORIENTATION_QUIRKS documenting that the
reason for a separate Kconfig for this is because
drm_panel_orientation_quirks.c code is shared with fbdev.

Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 0b166e626eb6..d853989848d6 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -27,6 +27,7 @@ config DRM_MIPI_DSI
 	bool
 	depends on DRM
 
+# Separate option because drm_panel_orientation_quirks.c is shared with fbdev
 config DRM_PANEL_ORIENTATION_QUIRKS
 	tristate
 
-- 
2.14.3

