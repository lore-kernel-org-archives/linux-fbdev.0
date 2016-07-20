From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 20 Jul 2016 01:11:05 +0000
Subject: [PATCH v2 07/13] gpu: ipu-v3: Add VDI input IDMAC channels
Message-Id: <1468977071-29240-8-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Adds the VDIC field input IDMAC channels. These channels
transfer fields F(n-1), F(n), and F(N+1) from memory to
the VDIC (channels 8, 9, 10 respectively).

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

---

v2:
- made the channel names more descriptive: "_PREV" instead of "_P", etc.
---
 include/video/imx-ipu-v3.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 74d3059..afbc89d 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -107,6 +107,9 @@ enum ipu_channel_irq {
 #define IPUV3_CHANNEL_CSI2			 2
 #define IPUV3_CHANNEL_CSI3			 3
 #define IPUV3_CHANNEL_VDI_MEM_IC_VF		 5
+#define IPUV3_CHANNEL_MEM_VDI_PREV		 8
+#define IPUV3_CHANNEL_MEM_VDI_CUR		 9
+#define IPUV3_CHANNEL_MEM_VDI_NEXT		10
 #define IPUV3_CHANNEL_MEM_IC_PP			11
 #define IPUV3_CHANNEL_MEM_IC_PRP_VF		12
 #define IPUV3_CHANNEL_G_MEM_IC_PRP_VF		14
-- 
1.9.1

