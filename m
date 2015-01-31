From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 31 Jan 2015 13:47:39 +0000
Subject: [PATCH 09/15] fbdev: kconfig: replace PPC_OF with PPC
Message-Id: <1422712065-9403-10-git-send-email-haokexin@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 55161dd4b931..027f9b685b5b 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -479,7 +479,7 @@ config FB_ATARI
 
 config FB_OF
 	bool "Open Firmware frame buffer device support"
-	depends on (FB = y) && (PPC64 || PPC_OF) && (!PPC_PSERIES || PCI)
+	depends on (FB = y) && PPC && (!PPC_PSERIES || PCI)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.9.3

