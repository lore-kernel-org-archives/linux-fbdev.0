From: Samreen <samreen@ti.com>
Date: Tue, 16 Nov 2010 11:54:17 +0000
Subject: [PATCH v2] OMAP: DSS2: OMAPFB: Add null pointer check
Message-Id: <1289908147-12468-1-git-send-email-samreen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Samreen <samreen@ti.com>

A null pointer check added. And using kstrdup()
instead of kmalloc() & strcpy()

Signed-off-by: Samreen <samreen@ti.com>
---
Version2:
   - Using kstrdup() instead of kmalloc() & strcpy()
   - Using ENOMEM as error code instead of EINVAL
   - Subject changed appropriately

The link to v1 of patch is:
https://patchwork.kernel.org/patch/319642/

 drivers/video/omap2/omapfb/omapfb-main.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 6a704f1..4fdab8e 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2132,8 +2132,9 @@ static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
 	char *str, *options, *this_opt;
 	int r = 0;
 
-	str = kmalloc(strlen(def_mode) + 1, GFP_KERNEL);
-	strcpy(str, def_mode);
+	str = kstrdup(def_mode, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
 	options = str;
 
 	while (!r && (this_opt = strsep(&options, ",")) != NULL) {
-- 
1.5.6.3

