From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Aug 2012 06:09:47 +0000
Subject: [PATCH 1/2] OMAPDSS: Fix SDI PLL locking
Message-Id: <1345529388-3509-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Commit f476ae9dab3234532d41d36beb4ba7be838fa786 (OMAPDSS: APPLY: Remove
DISPC writes to manager's lcd parameters in interface) broke the SDI
output, as it causes the SDI PLL locking to fail.

LCLK and PCLK divisors are located in shadow registers, and we normally
write them to DISPC registers when enabling the output.  However, SDI
uses pck-free as source clock for its PLL, and pck-free is affected by
the divisors. And as we need the PLL before enabling the output, we need
to write the divisors early.

It seems just writing to the DISPC register is enough, and we don't need
to care about the shadow register mechanism for pck-free. The exact
reason for this is unknown.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/video/omap2/dss/sdi.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 5d31699..f43bfe1 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -105,6 +105,20 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	sdi_config_lcd_manager(dssdev);
 
+	/*
+	 * LCLK and PCLK divisors are located in shadow registers, and we
+	 * normally write them to DISPC registers when enabling the output.
+	 * However, SDI uses pck-free as source clock for its PLL, and pck-free
+	 * is affected by the divisors. And as we need the PLL before enabling
+	 * the output, we need to write the divisors early.
+	 *
+	 * It seems just writing to the DISPC register is enough, and we don't
+	 * need to care about the shadow register mechanism for pck-free. The
+	 * exact reason for this is unknown.
+	 */
+	dispc_mgr_set_clock_div(dssdev->manager->id,
+			&sdi.mgr_config.clock_info);
+
 	dss_sdi_init(dssdev->phy.sdi.datapairs);
 	r = dss_sdi_enable();
 	if (r)
-- 
1.7.9.5

