From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 31 Mar 2011 10:10:59 +0000
Subject: [PATCH 2/9] OMAP: DSS2: remove non-working msleep(40) workaround
Message-Id: <1301566266-11187-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The sleep workaround for the problem described in the comment doesn't
really work. This patch removes the workaround, and improves the comment
about the bug, and proposes an userspace workaround.

omap_dss_set_manager() is called 6 times when loading omapdss and
omapfb, which means that 40ms * 6 = 240ms was spent sleeping when
booting up.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/overlay.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index f1aca6d..fcde51b 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -491,13 +491,18 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 	ovl->manager = mgr;
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
-	/* XXX: on manual update display, in auto update mode, a bug happens
-	 * here. When an overlay is first enabled on LCD, then it's disabled,
-	 * and the manager is changed to TV, we sometimes get SYNC_LOST_DIGIT
-	 * errors. Waiting before changing the channel_out fixes it. I'm
-	 * guessing that the overlay is still somehow being used for the LCD,
-	 * but I don't understand how or why. */
-	msleep(40);
+	/* XXX: When there is an overlay on a DSI manual update display, and
+	 * the overlay is first disabled, then moved to tv, and enabled, we
+	 * seem to get SYNC_LOST_DIGIT error.
+	 *
+	 * Waiting doesn't seem to help, but updating the manual update display
+	 * after disabling the overlay seems to fix this. This hints that the
+	 * overlay is perhaps somehow tied to the LCD output until the output
+	 * is updated.
+	 *
+	 * Userspace workaround for this is to update the LCD after disabling
+	 * the overlay, but before moving the overlay to TV.
+	 */
 	dispc_set_channel_out(ovl->id, mgr->id);
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 
-- 
1.7.1

