From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 22 Jul 2019 18:24:36 +0000
Subject: [PATCH 1/4] video: of: display_timing: Add of_node_put() in of_get_display_timing()
Message-Id: <20190722182439.44844-2-dianders@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722182439.44844-1-dianders@chromium.org>
In-Reply-To: <20190722182439.44844-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Russell King <linux@armlinux.org.uk>, Daniel Vetter <daniel@ffwll.ch>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org

From code inspection it can be seen that of_get_display_timing() is
lacking an of_node_put().  Add it.

Fixes: ffa3fd21de8a ("videomode: implement public of_get_display_timing()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/video/of_display_timing.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index f5c1c469c0af..5eedae0799f0 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -119,6 +119,7 @@ int of_get_display_timing(const struct device_node *np, const char *name,
 		struct display_timing *dt)
 {
 	struct device_node *timing_np;
+	int ret;
 
 	if (!np)
 		return -EINVAL;
@@ -129,7 +130,11 @@ int of_get_display_timing(const struct device_node *np, const char *name,
 		return -ENOENT;
 	}
 
-	return of_parse_display_timing(timing_np, dt);
+	ret = of_parse_display_timing(timing_np, dt);
+
+	of_node_put(timing_np);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_get_display_timing);
 
-- 
2.22.0.657.g960e92d24f-goog
