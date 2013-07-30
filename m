From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 30 Jul 2013 18:26:27 +0000
Subject: [PATCH v2 20/24] video: da8xx-fb: ensure pdata only for non-dt
Message-Id: <1375208791-15781-21-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

This driver is DT probe-able, hence ensure presence of platform data
only for non-DT boot.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index ca8f6fc..697b07c 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1304,7 +1304,7 @@ static int fb_probe(struct platform_device *device)
 	int ret;
 	unsigned long ulcm;
 
-	if (fb_pdata = NULL) {
+	if (fb_pdata = NULL && !device->dev.of_node) {
 		dev_err(&device->dev, "Can not get platform data\n");
 		return -ENOENT;
 	}
-- 
1.7.0.4

