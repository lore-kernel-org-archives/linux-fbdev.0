From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 20 Jul 2016 01:11:07 +0000
Subject: [PATCH v2 09/13] gpu: ipu-v3: Fix CSI data format for 16-bit media bus formats
Message-Id: <1468977071-29240-10-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

The CSI data format was being programmed incorrectly for the
1x16 media bus formats. The CSI data format for 16-bit must
be bayer/generic (CSI_SENS_CONF_DATA_FMT_BAYER).

Suggested-by: Carsten Resch <Carsten.Resch@de.bosch.com>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-csi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-csi.c b/drivers/gpu/ipu-v3/ipu-csi.c
index 641ed76..d6e5ded 100644
--- a/drivers/gpu/ipu-v3/ipu-csi.c
+++ b/drivers/gpu/ipu-v3/ipu-csi.c
@@ -258,12 +258,8 @@ static int mbus_code_to_bus_cfg(struct ipu_csi_bus_config *cfg, u32 mbus_code)
 		cfg->data_width = IPU_CSI_DATA_WIDTH_8;
 		break;
 	case MEDIA_BUS_FMT_UYVY8_1X16:
-		cfg->data_fmt = CSI_SENS_CONF_DATA_FMT_YUV422_UYVY;
-		cfg->mipi_dt = MIPI_DT_YUV422;
-		cfg->data_width = IPU_CSI_DATA_WIDTH_16;
-		break;
 	case MEDIA_BUS_FMT_YUYV8_1X16:
-		cfg->data_fmt = CSI_SENS_CONF_DATA_FMT_YUV422_YUYV;
+		cfg->data_fmt = CSI_SENS_CONF_DATA_FMT_BAYER;
 		cfg->mipi_dt = MIPI_DT_YUV422;
 		cfg->data_width = IPU_CSI_DATA_WIDTH_16;
 		break;
-- 
1.9.1

