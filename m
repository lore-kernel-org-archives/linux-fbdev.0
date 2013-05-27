From: Lucas Stach <l.stach@pengutronix.de>
Date: Mon, 27 May 2013 12:33:34 +0000
Subject: [PATCH 2/3] video: of: display_timing: add doubleclk flag
Message-Id: <1369658015-11743-2-git-send-email-l.stach@pengutronix.de>
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
 Documentation/devicetree/bindings/video/display-timing.txt |    1 +
 drivers/video/of_display_timing.c                          |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/display-timing.txt b/Documentation/devicetree/bindings/video/display-timing.txt
index 1500385..e1d4a0b 100644
--- a/Documentation/devicetree/bindings/video/display-timing.txt
+++ b/Documentation/devicetree/bindings/video/display-timing.txt
@@ -34,6 +34,7 @@ optional properties:
 			- ignored     = ignored
  - interlaced (bool): boolean to enable interlaced mode
  - doublescan (bool): boolean to enable doublescan mode
+ - doubleclk (bool): boolean to enable doubleclock mode
 
 All the optional properties that are not bool follow the following logic:
     <1>: high active
diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 85c1a41..2894e03 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -98,6 +98,8 @@ static struct display_timing *of_get_display_timing(const struct device_node
 		dt->flags |= DISPLAY_FLAGS_INTERLACED;
 	if (of_property_read_bool(np, "doublescan"))
 		dt->flags |= DISPLAY_FLAGS_DOUBLESCAN;
+	if (of_property_read_bool(np, "doubleclk"))
+		dt->flags |= DISPLAY_FLAGS_DOUBLECLK;
 
 	if (ret) {
 		pr_err("%s: error reading timing properties\n",
-- 
1.7.10.4

