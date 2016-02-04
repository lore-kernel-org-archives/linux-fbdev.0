From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Feb 2016 14:04:15 +0000
Subject: [PATCH 06/11] Documentation/DT: add blurb for IB2 syscon to Versatile
Message-Id: <1454594660-7532-7-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The ARM Versatile has an optional daughterboard, if this is
mounted, we need to be able to access its system controller.
Put in a documentation blurb for this.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/arm-boards | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 1a709970e7f7..2daeabc519de 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -93,6 +93,14 @@ Required nodes:
   a core-module with regs and the compatible strings
   "arm,core-module-versatile", "syscon"
 
+Optional nodes:
+
+- arm,versatile-ib2-syscon : if the Versatile has an IB2 interface
+  board mounted, this has a separate system controller that is
+  defined in this node.
+  Required properties:
+  compatible = "arm,versatile-ib2-syscon", "syscon"
+
 ARM RealView Boards
 -------------------
 The RealView boards cover tailored evaluation boards that are used to explore
-- 
2.4.3

