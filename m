From: Lucas Stach <l.stach@pengutronix.de>
Date: Mon, 27 May 2013 12:33:35 +0000
Subject: [PATCH 3/3] drm_modes: videomode: add doubleclk flag
Message-Id: <1369658015-11743-3-git-send-email-l.stach@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369658015-11743-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1369658015-11743-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, kernel@pengutronix.de, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/gpu/drm/drm_modes.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index faa79df..875031d 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -535,6 +535,8 @@ int drm_display_mode_from_videomode(const struct videomode *vm,
 		dmode->flags |= DRM_MODE_FLAG_INTERLACE;
 	if (vm->flags & DISPLAY_FLAGS_DOUBLESCAN)
 		dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
+	if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
+		dmode->flags |= DRM_MODE_FLAG_DBLCLK;
 	drm_mode_set_name(dmode);
 
 	return 0;
-- 
1.7.10.4

