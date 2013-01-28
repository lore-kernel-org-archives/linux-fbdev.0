From: Afzal Mohammed <afzal@ti.com>
Date: Mon, 28 Jan 2013 09:33:36 +0000
Subject: [PATCH v5 10/12] video: da8xx-fb: ensure pdata only for non-dt
Message-Id: <7b6a238cea5097bb1b92b03bb78a0b53b423cec5.1359356015.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1359356015.git.afzal@ti.com>
In-Reply-To: <cover.1359356015.git.afzal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Mike Turquette <mturquette@linaro.org>

This driver is DT probe-able, hence ensure presence of platform data
only for non-DT boot.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 0c68712..1c1a616 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1303,7 +1303,7 @@ static int fb_probe(struct platform_device *device)
 	int ret;
 	unsigned long ulcm;
 
-	if (fb_pdata = NULL) {
+	if (fb_pdata = NULL && !device->dev.of_node) {
 		dev_err(&device->dev, "Can not get platform data\n");
 		return -ENOENT;
 	}
-- 
1.7.12

