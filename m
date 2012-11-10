From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Date: Sat, 10 Nov 2012 11:46:43 +0000
Subject: [PATCH 0/2] Adding devm_ functions and DT support to MIPI driver
Message-Id: <1352547285-12302-1-git-send-email-shaik.ameer@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In this patch series,

First patch adds the devm_ functions to the driver code for automatic
code cleanup.

Second patch adds the DT support for the exynos mipi-dsi driver.
for DT support, mipi device node should supply the following
information to the mipi-dsi driver.
1] dsim_config information
2] d-phy setting information
3] lcd poweron, reset information
4] fb_videomode information

refer the documentation files for further details.

Shaik Ameer Basha (2):
  exynos-mipi-dsi: using devm_ functions for automatic cleanup
  video: exynos-mipi-dsi: Adding DT support to exynos mipi driver

 .../devicetree/bindings/video/exynos/mipi-dsi.txt  |  185 ++++++
 drivers/video/exynos/exynos_mipi_dsi.c             |  645 +++++++++++++++++---
 include/video/exynos_mipi_dsim.h                   |   27 +
 3 files changed, 783 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/exynos/mipi-dsi.txt

