From: Baruch Siach <baruch@tkos.co.il>
Date: Wed, 10 Feb 2010 07:25:18 +0000
Subject: [PATCH 1/3] imxfb: add support for i.MX25
Message-Id: <0bea69783cf8f6b04c64fed75f10c3dd3c567fb4.1265786237.git.baruch@tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1265786237.git.baruch@tkos.co.il>
In-Reply-To: <cover.1265786237.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5a5c303..7ff9acc 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -402,7 +402,7 @@ config FB_SA1100
 
 config FB_IMX
 	tristate "Motorola i.MX LCD support"
-	depends on FB && (ARCH_MX1 || ARCH_MX2)
+	depends on FB && (ARCH_MX1 || ARCH_MX2 || ARCH_MX25)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.6.6.1

