From: niederp@physik.uni-kl.de
Date: Fri, 06 Feb 2015 22:28:07 +0000
Subject: [PATCH 1/8] Documentation: dts: add missing Solomon Systech vendor prefix.
Message-Id: <1423261694-5939-2-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

From: Thomas Niederprüm <niederp@physik.uni-kl.de>

This patch adds the solomon prefix for Solomon Systech Limited.

Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a344ec2..b1d9470 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -143,6 +143,7 @@ sitronix	Sitronix Technology Corporation
 smsc	Standard Microsystems Corporation
 snps	Synopsys, Inc.
 solidrun	SolidRun
+solomon	Solomon Systech Limited
 sony	Sony Corporation
 spansion	Spansion Inc.
 st	STMicroelectronics
-- 
2.1.1

