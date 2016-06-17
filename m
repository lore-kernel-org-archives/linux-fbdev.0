From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 17 Jun 2016 17:11:53 +0000
Subject: [PATCH] drm/panel: simple: Update backlight state property
Message-Id: <20160617171153.30504-1-thierry.reding@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org

From: Thierry Reding <treding@nvidia.com>

Some backlight drivers ignore the power property and instead only use
the state property. Fixup the panel driver to set the state property in
addition to the power property.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Jingoo, Lee,

What's the correct way to do this? Should we update both power and state
properties, or just state? I didn't find code anywhere to keep both in
sync, so it seemed like both needed to be set explicitly.

 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 359cd37d09cb..f503d12b3930 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -168,6 +168,7 @@ static int panel_simple_disable(struct drm_panel *panel)
 
 	if (p->backlight) {
 		p->backlight->props.power = FB_BLANK_POWERDOWN;
+		p->backlight->props.state |= BL_CORE_FBBLANK;
 		backlight_update_status(p->backlight);
 	}
 
@@ -235,6 +236,7 @@ static int panel_simple_enable(struct drm_panel *panel)
 		msleep(p->desc->delay.enable);
 
 	if (p->backlight) {
+		p->backlight->props.state &= ~BL_CORE_FBBLANK;
 		p->backlight->props.power = FB_BLANK_UNBLANK;
 		backlight_update_status(p->backlight);
 	}
-- 
2.8.3

