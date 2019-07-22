From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 22 Jul 2019 18:24:38 +0000
Subject: [PATCH 3/4] drm: panel-lvds: Spout an error if of_get_display_timing() gives an error
Message-Id: <20190722182439.44844-4-dianders@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722182439.44844-1-dianders@chromium.org>
In-Reply-To: <20190722182439.44844-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Russell King <linux@armlinux.org.uk>, Daniel Vetter <daniel@ffwll.ch>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org

In the patch ("video: of: display_timing: Don't yell if no timing node
is present") we'll stop spouting an error directly in
of_get_display_timing() if no node is present.  Presumably panel-lvds
should take charge of spouting its own error now.

NOTE: we'll print two errors if the node was present but there were
problems parsing the timing node (one in of_parse_display_timing() and
this new one).  Since this is a fatal error for the driver's probe
(and presumably someone will be debugging), this should be OK.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-lvds.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 1ec57d0806a8..ad47cc95459e 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -147,8 +147,11 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	int ret;
 
 	ret = of_get_display_timing(np, "panel-timing", &timing);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(lvds->dev, "%pOF: problems parsing panel-timing (%d)\n",
+			np, ret);
 		return ret;
+	}
 
 	videomode_from_timing(&timing, &lvds->video_mode);
 
-- 
2.22.0.657.g960e92d24f-goog
