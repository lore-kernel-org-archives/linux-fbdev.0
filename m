From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 20 Jul 2016 01:11:11 +0000
Subject: [PATCH v2 13/13] gpu: ipu-v3: rename CSI client device
Message-Id: <1468977071-29240-14-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Rename the CSI client device in the client_reg[] table to
"imx-ipuv3-csi".

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index bb0377b..464c1c1 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1159,14 +1159,14 @@ static struct ipu_platform_reg client_reg[] = {
 			.dma[0] = IPUV3_CHANNEL_CSI0,
 			.dma[1] = -EINVAL,
 		},
-		.name = "imx-ipuv3-camera",
+		.name = "imx-ipuv3-csi",
 	}, {
 		.pdata = {
 			.csi = 1,
 			.dma[0] = IPUV3_CHANNEL_CSI1,
 			.dma[1] = -EINVAL,
 		},
-		.name = "imx-ipuv3-camera",
+		.name = "imx-ipuv3-csi",
 	}, {
 		.pdata = {
 			.di = 0,
-- 
1.9.1

