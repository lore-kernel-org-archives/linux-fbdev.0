From: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Tue, 30 Oct 2012 18:18:07 +0000
Subject: [PATCH] da8xx: Allow use by am33xx based devices
Message-Id: <1351698968-3965-1-git-send-email-panto@antoniou-consulting.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org

This driver can be used for AM33xx devices, like the popular beaglebone.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 drivers/video/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 9791d10..e7868d8 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2202,7 +2202,7 @@ config FB_SH7760
 
 config FB_DA8XX
 	tristate "DA8xx/OMAP-L1xx Framebuffer support"
-	depends on FB && ARCH_DAVINCI_DA8XX
+	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.7.12

