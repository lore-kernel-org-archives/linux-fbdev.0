From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 03 May 2012 10:57:13 +0000
Subject: [PATCH 3/4] OMAPDSS: TPO-TD03MTEA1: Check for errors from regulator_enable()
Message-Id: <1336042634-28486-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336042634-28486-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1336042634-28486-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

It is possible for regulator_enable() to fail and if it does fail that's
generally a bad sign for anything we try to do with the hardware afterwards
so check for and immediately return an error if regulator_enable() fails.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/displays/panel-tpo-td043mtea1.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 32f3fcd..74c6b87 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -272,11 +272,14 @@ static const struct omap_video_timings tpo_td043_timings = {
 static int tpo_td043_power_on(struct tpo_td043_device *tpo_td043)
 {
 	int nreset_gpio = tpo_td043->nreset_gpio;
+	int r;
 
 	if (tpo_td043->powered_on)
 		return 0;
 
-	regulator_enable(tpo_td043->vcc_reg);
+	r = regulator_enable(tpo_td043->vcc_reg);
+	if (r != 0)
+		return r;
 
 	/* wait for regulator to stabilize */
 	msleep(160);
-- 
1.7.10

