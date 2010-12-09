From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 09 Dec 2010 13:47:19 +0000
Subject: [PATCH 7/9] ARM i.MX5: Allow to increase max zone order
Message-Id: <1291902441-24712-8-git-send-email-s.hauer@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

default setting of 11 allows us to allocate at maximum
2MB chunks of contiguous memory. For resolutions up to
1920x1080 32bpp we need much more memory, so make zone
order configurable

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db524e7..b3e070e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1410,8 +1410,8 @@ config SPARSE_IRQ
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE
-	range 11 64 if ARCH_SHMOBILE
+	int "Maximum zone order" if ARCH_SHMOBILE || ARCH_MX5
+	range 11 64 if ARCH_SHMOBILE || ARCH_MX5
 	default "9" if SA1111
 	default "11"
 	help
-- 
1.7.2.3

