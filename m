From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Feb 2016 14:04:16 +0000
Subject: [PATCH 07/11] Documentation/DT: add Versatile display bindings
Message-Id: <1454594660-7532-8-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This adds bindings for the LCD displays that can be found connected
to the ARM Versatile reference design, interface boards IB1 and
IB2.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/display/panel/epson,l2f50113t00.txt        | 7 +++++++
 .../devicetree/bindings/display/panel/sanyo,alr252rgt.txt          | 7 +++++++
 .../devicetree/bindings/display/panel/sanyo,tm38qv67a02a.txt       | 7 +++++++
 .../devicetree/bindings/display/panel/sharp,lq084v1dg21.txt        | 7 +++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt              | 1 +
 5 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/epson,l2f50113t00.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sanyo,alr252rgt.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sanyo,tm38qv67a02a.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq084v1dg21.txt

diff --git a/Documentation/devicetree/bindings/display/panel/epson,l2f50113t00.txt b/Documentation/devicetree/bindings/display/panel/epson,l2f50113t00.txt
new file mode 100644
index 000000000000..58eca804dbe8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/epson,l2f50113t00.txt
@@ -0,0 +1,7 @@
+Epson Mobile display
+
+Required properties:
+- compatible: should be "epson,l2f50113t00"
+
+This binding is compatible with the panel-dpi binding, which is specified
+in panel-dpi.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/sanyo,alr252rgt.txt b/Documentation/devicetree/bindings/display/panel/sanyo,alr252rgt.txt
new file mode 100644
index 000000000000..d24562b34cd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sanyo,alr252rgt.txt
@@ -0,0 +1,7 @@
+Sanyo Electric Co. 2.5" panel
+
+Required properties:
+- compatible: should be "sanyo,alr252rgt"
+
+This binding is compatible with the panel-dpi binding, which is specified
+in panel-dpi.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/sanyo,tm38qv67a02a.txt b/Documentation/devicetree/bindings/display/panel/sanyo,tm38qv67a02a.txt
new file mode 100644
index 000000000000..c1582012d52e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sanyo,tm38qv67a02a.txt
@@ -0,0 +1,7 @@
+Sanyo Electric Co. 3.8" panel
+
+Required properties:
+- compatible: should be "sanyo,tm38qv67a02a"
+
+This binding is compatible with the panel-dpi binding, which is specified
+in panel-dpi.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq084v1dg21.txt b/Documentation/devicetree/bindings/display/panel/sharp,lq084v1dg21.txt
new file mode 100644
index 000000000000..8318c2422740
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq084v1dg21.txt
@@ -0,0 +1,7 @@
+Sharp 8.4" VGA color TFT
+
+Required properties:
+- compatible: should be "sharp,lq084v1dg21"
+
+This binding is compatible with the panel-dpi binding, which is specified
+in panel-dpi.txt in this directory.
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 72e2c5a2b327..da5d8bf13818 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -198,6 +198,7 @@ ricoh	Ricoh Co. Ltd.
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
 samsung	Samsung Semiconductor
 sandisk	Sandisk Corporation
+sanyo	Sanyo Electric Co., Ltd.
 sbs	Smart Battery System
 schindler	Schindler
 seagate	Seagate Technology PLC
-- 
2.4.3

