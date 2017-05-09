From: Olimpiu Dejeu <olimpiu@arcticsand.com>
Date: Tue, 09 May 2017 12:50:04 +0000
Subject: [PATCH v10 1/3] DT add arctic to vendor prefix for ArcticSand
Message-Id: <1494334204-24633-1-git-send-email-olimpiu@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1494270034-22902-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1494270034-22902-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, bdodge@arcticsand.com, joe@perches.com, daniel.thompson@linaro.org, lkp@intel.com, fengguang.wu@intel.com, Olimpiu Dejeu <olimpiu@arcticsand.com>

dt-bindings: vendor-prefixes: add arctic to vendor prefix

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
---
v9 => v10:
- (Re-submit) Per Rob Herring's request changed vendor-prefix to arctic
v8 => v9:
- Version updated to match other patch in set. No other changes.
v8:
- Version to match other patches in set

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 16d3b5e..6f33a4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -28,6 +28,7 @@ andestech	Andes Technology Corporation
 apm	Applied Micro Circuits Corporation (APM)
 aptina	Aptina Imaging
 arasan	Arasan Chip Systems
+arctic	Arctic Sand
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
-- 
2.7.4

