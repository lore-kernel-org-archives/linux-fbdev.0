From: Cesar Eduardo Barros <cesarb@cesarb.net>
Date: Tue, 11 Dec 2012 21:49:52 +0000
Subject: [PATCH 10/19] MAINTAINERS: fix .../plat-mxc/include/mach/imxfb.h
Message-Id: <1355262601-4263-11-git-send-email-cesarb@cesarb.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355262601-4263-1-git-send-email-cesarb@cesarb.net>
In-Reply-To: <1355262601-4263-1-git-send-email-cesarb@cesarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This file was moved to include/linux/platform_data/video-imxfb.h by
commit 82906b1 (ARM: imx: move platform_data definitions).

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bf84d4..9bc4861d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3138,7 +3138,7 @@ M:	Sascha Hauer <kernel@pengutronix.de>
 L:	linux-fbdev@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/plat-mxc/include/mach/imxfb.h
+F:	include/linux/platform_data/video-imxfb.h
 F:	drivers/video/imxfb.c
 
 FREESCALE SOC FS_ENET DRIVER
-- 
1.7.11.7

