From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 17 Apr 2013 15:17:14 +0000
Subject: [RFC 02/10] video: display: Update the display with the video mode data
Message-Id: <1366211842-21497-3-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>

The display entity (sink) may need to know about the mode being
changed, eg. to update timings.

Alternatively there could be a separate set_mode() operation...

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/video/display/display-core.c |    5 +++--
 include/video/display.h              |    6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/display/display-core.c b/drivers/video/display/display-core.c
index d2daa15..4b8e45a 100644
--- a/drivers/video/display/display-core.c
+++ b/drivers/video/display/display-core.c
@@ -69,12 +69,13 @@ EXPORT_SYMBOL_GPL(display_entity_set_state);
  *
  * Return 0 on success or a negative error code otherwise.
  */
-int display_entity_update(struct display_entity *entity)
+int display_entity_update(struct display_entity *entity,
+			     const struct videomode *mode)
 {
 	if (!entity->ops.ctrl || !entity->ops.ctrl->update)
 		return 0;
 
-	return entity->ops.ctrl->update(entity);
+	return entity->ops.ctrl->update(entity, mode);
 }
 EXPORT_SYMBOL_GPL(display_entity_update);
 
diff --git a/include/video/display.h b/include/video/display.h
index 90d18ca..64f84d5 100644
--- a/include/video/display.h
+++ b/include/video/display.h
@@ -77,7 +77,8 @@ struct display_entity_interface_params {
 struct display_entity_control_ops {
 	int (*set_state)(struct display_entity *ent,
 			 enum display_entity_state state);
-	int (*update)(struct display_entity *ent);
+	int (*update)(struct display_entity *ent,
+			 const struct videomode *mode);
 	int (*get_modes)(struct display_entity *ent,
 			 const struct videomode **modes);
 	int (*get_params)(struct display_entity *ent,
@@ -111,7 +112,8 @@ struct display_entity {
 
 int display_entity_set_state(struct display_entity *entity,
 			     enum display_entity_state state);
-int display_entity_update(struct display_entity *entity);
+int display_entity_update(struct display_entity *entity,
+			     const struct videomode *mode);
 int display_entity_get_modes(struct display_entity *entity,
 			     const struct videomode **modes);
 int display_entity_get_params(struct display_entity *entity,
-- 
1.7.10.4


