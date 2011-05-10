From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2011 16:24:13 +0000
Subject: [PATCH 5/8] OMAP: DSS2: RFBI: add omap_rfbi_configure
Message-Id: <1305044656-31512-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add omap_rfbi_configure() which the panel driver can use to reconfigure
the data element size and the number of data lines in the RFBI bus.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 ++
 drivers/video/omap2/dss/rfbi.c            |    8 +++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index e6629eb..7215a8d 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -614,5 +614,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 int omap_rfbi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(void *), void *data);
+int omap_rfbi_configure(struct omap_dss_device *dssdev, int pixel_size,
+		int data_lines);
 
 #endif
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index fadfaae..e6bbb67 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -851,7 +851,13 @@ int rfbi_configure(int rfbi_module, int bpp, int lines)
 
 	return 0;
 }
-EXPORT_SYMBOL(rfbi_configure);
+
+int omap_rfbi_configure(struct omap_dss_device *dssdev, int pixel_size,
+		int data_lines)
+{
+	return rfbi_configure(dssdev->phy.rfbi.channel, pixel_size, data_lines);
+}
+EXPORT_SYMBOL(omap_rfbi_configure);
 
 int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 		u16 *x, u16 *y, u16 *w, u16 *h)
-- 
1.7.4.1

