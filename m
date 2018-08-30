From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 30 Aug 2018 21:00:12 +0000
Subject: [PATCH v2 12/12] drm/tegra: kick out simplefb
Message-Id: <985a03e73608bcab0ec84b67edb69e334bd012fe.1535656077.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Alex Deucher <alexander.deucher@amd.com>, Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org

Kick out firmware fb when loading Tegra driver.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/tegra/drm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 7afe2f635f74..b51ec138fed2 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1203,6 +1203,10 @@ static int host1x_drm_probe(struct host1x_device *dev)
 
 	dev_set_drvdata(&dev->dev, drm);
 
+	err = drm_fb_helper_remove_conflicting_framebuffers(NULL, "tegradrmfb", false);
+	if (err < 0)
+		goto unref;
+
 	err = drm_dev_register(drm, 0);
 	if (err < 0)
 		goto unref;
-- 
2.18.0
