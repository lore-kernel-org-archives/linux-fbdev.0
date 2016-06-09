From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Thu, 09 Jun 2016 09:44:21 +0000
Subject: [RFC v4 04/14] MAINTAINERS: Retain Ulf Hansson as the same maintainer of pwrseq
Message-Id: <1465465471-28740-5-git-send-email-k.kozlowski@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Before moving pwrseq drivers from drivers/mmc/core/ to drivers/power/,
they were maintained by Ulf Hansson.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f2a75ce5442..71114607502a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9083,6 +9083,15 @@ F:	include/linux/power_supply.h
 F:	drivers/power/
 X:	drivers/power/avs/
 
+POWER SEQ CORE and DRIVERS
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-mmc@vger.kernel.org
+T:	git git://git.linaro.org/people/ulf.hansson/mmc.git
+S:	Maintained
+F:	drivers/power/pwrseq/
+F:	include/linux/pwrseq.h
+F:	Documentation/devicetree/bindings/power/pwrseq/
+
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-- 
1.9.1

