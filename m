From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 19 Mar 2012 15:02:32 +0000
Subject: [PATCH 2/2] OMAPDSS: TPO-TD03MTEA1: Correct comment for power on delay
Message-Id: <1332169352-5076-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Since any power on stabilisation delay for the supply itself should be
taken care of transparently by the regulator API when the regulator is
enabled the additional delay that the TPO-TD03MTEA1 driver adds after
that returned should be due to the requirements of the device itself
rather than the supply (the delay is also suspicously long for one for
a regulator to ramp). Correct the comment to avoid misleading people
taking this code as a reference.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 74c6b87..987cb84 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -281,7 +281,7 @@ static int tpo_td043_power_on(struct tpo_td043_device *tpo_td043)
 	if (r != 0)
 		return r;
 
-	/* wait for regulator to stabilize */
+	/* wait for panel to stabilize */
 	msleep(160);
 
 	if (gpio_is_valid(nreset_gpio))
-- 
1.7.9.1

