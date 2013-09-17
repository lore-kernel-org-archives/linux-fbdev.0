From: Archit Taneja <archit@ti.com>
Date: Tue, 17 Sep 2013 07:18:35 +0000
Subject: [PATCH 09/11] omapdss: OMAP4: HDMI: remove unnecessary edid macros
Message-Id: <1379401597-27222-10-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379401597-27222-1-git-send-email-archit@ti.com>
In-Reply-To: <1379401597-27222-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The hdmi4 driver has edid macros that aren't used at all. Remove them.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi4.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index 324ecd0..ab43069 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -38,14 +38,6 @@
 #include "dss.h"
 #include "dss_features.h"
 
-/* HDMI EDID Length move this */
-#define HDMI_EDID_MAX_LENGTH			256
-#define EDID_TIMING_DESCRIPTOR_SIZE		0x12
-#define EDID_DESCRIPTOR_BLOCK0_ADDRESS		0x36
-#define EDID_DESCRIPTOR_BLOCK1_ADDRESS		0x80
-#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR	4
-#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR	4
-
 static struct {
 	struct mutex lock;
 	struct platform_device *pdev;
-- 
1.8.1.2

