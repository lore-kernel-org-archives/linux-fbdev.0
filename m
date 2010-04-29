From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 29 Apr 2010 23:49:35 +0000
Subject: [PATCH 2/5] fsl-diu-fb: move fsl-diu-fb.h to include/linux
Message-Id: <1272584978-19063-3-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
In-Reply-To: <1272584978-19063-1-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org

Some DIU structures will be used in platform code in
subsequent MPC5121 DIU patch, so we move this header
to be able to include it elsewhere.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/fsl-diu-fb.c                    |    2 +-
 {drivers/video => include/linux}/fsl-diu-fb.h |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename {drivers/video => include/linux}/fsl-diu-fb.h (100%)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index ee15a99..7acdc09 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -34,7 +34,7 @@
 #include <linux/of_platform.h>
 
 #include <sysdev/fsl_soc.h>
-#include "fsl-diu-fb.h"
+#include <linux/fsl-diu-fb.h>
 
 /*
  * These parameters give default parameters
diff --git a/drivers/video/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
similarity index 100%
rename from drivers/video/fsl-diu-fb.h
rename to include/linux/fsl-diu-fb.h
-- 
1.6.3.3

