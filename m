From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 22 Jul 2019 18:24:39 +0000
Subject: [PATCH 4/4] video: amba-clcd: Spout an error if of_get_display_timing() gives an error
Message-Id: <20190722182439.44844-5-dianders@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722182439.44844-1-dianders@chromium.org>
In-Reply-To: <20190722182439.44844-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

In the patch ("video: of: display_timing: Don't yell if no timing node
is present") we'll stop spouting an error directly in
of_get_display_timing() if no node is present.  Presumably amba-clcd
should take charge of spouting its own error now.

NOTE: we'll print two errors if the node was present but there were
problems parsing the timing node (one in of_parse_display_timing() and
this new one).  Since this is a fatal error for the driver's probe
(and presumably someone will be debugging), this should be OK.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/video/fbdev/amba-clcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 89324e42a033..7de43be6ef2c 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -561,8 +561,10 @@ static int clcdfb_of_get_dpi_panel_mode(struct device_node *node,
 	struct videomode video;
 
 	err = of_get_display_timing(node, "panel-timing", &timing);
-	if (err)
+	if (err) {
+		pr_err("%pOF: problems parsing panel-timing (%d)\n", node, err);
 		return err;
+	}
 
 	videomode_from_timing(&timing, &video);
 
-- 
2.22.0.657.g960e92d24f-goog
