From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 09 Dec 2010 13:47:20 +0000
Subject: [PATCH 8/9] ARM i.MX5: increase dma consistent size for IPU support
Message-Id: <1291902441-24712-9-git-send-email-s.hauer@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/memory.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 9a9a000..a8152db 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -40,7 +40,7 @@
 # endif
 #endif
 
-#if defined(CONFIG_MX3_VIDEO)
+#if defined(CONFIG_MX3_VIDEO) || defined(CONFIG_MFD_IMX_IPU_V3)
 /*
  * Increase size of DMA-consistent memory region.
  * This is required for mx3 camera driver to capture at least two QXGA frames.
-- 
1.7.2.3

