From: Olimpiu Dejeu <olimpiu@arcticsand.com>
Date: Wed, 03 May 2017 15:04:17 +0000
Subject: [PATCH v10 1/3] backlight arcxcnn add arc to vendor prefix
Message-Id: <1493823859-22402-1-git-send-email-olimpiu@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bdodge-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>

backlight: Add arc to vendor prefixes
Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
---
v9 => v10:
- Per Rob Herring's request changed vendor-prefix to arctic
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

