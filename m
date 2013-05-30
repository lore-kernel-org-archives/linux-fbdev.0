From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:36:20 +0000
Subject: [PATCH 27/27] ARM: OMAP: add vdds_sdi supply for sdi.0
Message-Id: <1369906580-27585-28-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

SDI driver gets currently the vdds_sdi regulator via omapdss device.
This is not correct, and we'll change the SDI driver to get the
regulator directly.

This patch changes the rx51 board file to add vdds_dsi supply for sdi.0
device.

Note that the vdds_sdi supply for omapdss device is still left there, as
the current display driver uses it. When both the board files and the
display driver has been changed, we can remove the unused supply.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e35e0b6..c3270c0 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -565,6 +565,7 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 
 static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_sdi", "omapdss_sdi.0"),
 	/* Si4713 supply */
 	REGULATOR_SUPPLY("vdd", "2-0063"),
 	/* lis3lv02d */
-- 
1.8.1.2

