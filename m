From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, 12 Mar 2015 15:24:04 +0000
Subject: [PATCH 6/8] mtd: replace CONFIG_8xx by CONFIG_PPC_8xx
Message-Id: <20150312152404.D6C391A2421@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, user-mode-linux-user@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org

Two config options exist to define powerpc MPC8xx:
* CONFIG_PPC_8xx
* CONFIG_8xx
In addition, CONFIG_PPC_8xx also defines CONFIG_CPM1 as
communication co-processor

arch/powerpc/platforms/Kconfig.cputype has contained the following
comment about CONFIG_8xx item for some years:
"# this is temp to handle compat with arch=ppc"

It looks like not many places still have that old CONFIG_8xx used,
so it is likely to be a good time to get rid of it completely ?

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 drivers/mtd/maps/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index ba801d2..e715ae9 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -242,7 +242,7 @@ config MTD_L440GX
 
 config MTD_CFI_FLAGADM
 	tristate "CFI Flash device mapping on FlagaDM"
-	depends on 8xx && MTD_CFI
+	depends on PPC_8xx && MTD_CFI
 	help
 	  Mapping for the Flaga digital module. If you don't have one, ignore
 	  this setting.
-- 
2.1.0

