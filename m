From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 08 Jan 2010 13:22:41 +0000
Subject: [PATCH 07/15] OMAP: OMAPFB: add dummy release function for omapdss
Message-Id: <1262956969-1664-8-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

This should fix:
WARNING: at drivers/base/core.c:131 device_release+0x68/0x7c()
Device 'omapdss' does not have a release() function, it is broken and
must be fixed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap/omapfb_main.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index f74aec9..2c4f470 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -83,10 +83,17 @@ static struct caps_table_struct color_caps[] = {
 	{ 1 << OMAPFB_COLOR_YUY422,	"YUY422", },
 };
 
+static void omapdss_release(struct device *dev)
+{
+}
+
 /* dummy device for clocks */
 static struct platform_device omapdss_device = {
 	.name		= "omapdss",
 	.id		= -1,
+	.dev            = {
+		.release = omapdss_release,
+	},
 };
 
 /*
-- 
1.6.5

