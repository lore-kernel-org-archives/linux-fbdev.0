From: Afzal Mohammed <afzal@ti.com>
Date: Mon, 07 Jan 2013 05:23:41 +0000
Subject: [PATCH 09/10] video: da8xx-fb: ensure pdata only for non-dt
Message-Id: <d903563abfca211dac6413eccf2d33f517c84a5d.1357304090.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1357304090.git.afzal@ti.com>
In-Reply-To: <cover.1357304090.git.afzal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Sekhar Nori <nsekhar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org

This driver is DT probe-able, hence ensure presence of platform data
only for non-DT boot.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 94add01..3e590d4 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1306,7 +1306,7 @@ static int __devinit fb_probe(struct platform_device *device)
 	int ret;
 	unsigned long ulcm;
 
-	if (fb_pdata = NULL) {
+	if (fb_pdata = NULL && !device->dev.of_node) {
 		dev_err(&device->dev, "Can not get platform data\n");
 		return -ENOENT;
 	}
-- 
1.7.9.5

