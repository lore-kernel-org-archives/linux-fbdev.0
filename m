From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Fri, 19 Dec 2014 02:00:23 +0000
Subject: [PATCH v2 4/7] imx-drm: ipuv3-crtc: Implement mode_fixup
Message-Id: <1418954426-21909-5-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Philipp Zabel <p.zabel@pengutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Denis Carikli <denis@eukrea.com>, Jiada Wang <jiada_wang@mentor.com>, Steve Longerbeam <steve_longerbeam@mentor.com>

Ask the IPU display interface, via ipu_di_adjust_videomode(), to
adjust a video mode to meet any DI restrictions. The function takes
a subsystem independent videomode, so the drm_display_mode must be
converted to videomode first, and then the adjusted mode converted
back to a drm_display_mode.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/drm/imx/ipuv3-crtc.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
index 11e84a2..fb16026 100644
--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -242,6 +242,18 @@ static bool ipu_crtc_mode_fixup(struct drm_crtc *crtc,
 				  const struct drm_display_mode *mode,
 				  struct drm_display_mode *adjusted_mode)
 {
+	struct ipu_crtc *ipu_crtc = to_ipu_crtc(crtc);
+	struct videomode vm;
+	int ret;
+
+	videomode_from_drm_display_mode(adjusted_mode, &vm);
+
+	ret = ipu_di_adjust_videomode(ipu_crtc->di, &vm);
+	if (ret)
+		return false;
+
+	drm_display_mode_from_videomode(&vm, adjusted_mode);
+
 	return true;
 }
 
-- 
1.7.9.5

