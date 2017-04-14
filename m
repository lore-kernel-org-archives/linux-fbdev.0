From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Fri, 14 Apr 2017 13:50:04 +0000
Subject: [PATCH] video: console: Remove reference to CONFIG_8xx
Message-Id: <20170414135004.46D646831E@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org

CONFIG_8xx is deprecated and should soon be removed in favor
of CONFIG_PPC_8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 This is the last instance of CONFIG_8xx outside of arch/powerpc/

 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 5b71bd905a60..2111d06f8c81 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -6,7 +6,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
-	depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && \
+	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
 		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
-- 
2.12.0

