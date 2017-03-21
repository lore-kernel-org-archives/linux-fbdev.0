From: Olimpiu Dejeu <olimpiu@arcticsand.com>
Date: Tue, 21 Mar 2017 16:58:46 +0000
Subject: [PATCH v9 1/3] backlight arcxcnn add arc to vendor prefix
Message-Id: <1490115528-11044-1-git-send-email-olimpiu@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, bdodge@arcticsand.com, joe@perches.com, medasaro@arcticsand.com, daniel.thompson@linaro.org, lkp@intel.com, fengguang.wu@intel.com, Olimpiu Dejeu <olimpiu@arcticsand.com>

backlight: Add arc to vendor prefixes
Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
---
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
+arc	Arctic Sand
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
-- 
2.7.4

