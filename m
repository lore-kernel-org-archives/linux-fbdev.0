From: Thomas Schwinge <thomas@codesourcery.com>
Date: Fri, 09 Mar 2012 16:38:53 +0000
Subject: [PATCH 7/7] sm501: restore big-endian operation.
Message-Id: <1331311133-26937-7-git-send-email-thomas@codesourcery.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Schwinge <thomas@codesourcery.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Heiko Schocher <hs@denx.de>, Samuel Ortiz <sameo@linux.intel.com>, linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, Ben Dooks <ben@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Randy Dunlap <rdunlap@xenotime.net>

On SH, as of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
endianess-agnostic I/O accessor functions.

In commit bf5f0019046d596d613caf74722ba4994e153899, Heiko fixed this for 32-bit
PowerPC; my patch now generalizes upon that.

The device is now recognized correctly for both litte-endian and big-endian
sh7785lcr, but I have not tested this any further, as the board is situated in
a remote data center.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org
Cc: devicetree-discuss@ozlabs.org
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: Vincent Sanders <vince@simtec.co.uk>
Cc: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/sm501.h |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/sm501.h b/include/linux/sm501.h
index 02fde50..0312e3c 100644
--- a/include/linux/sm501.h
+++ b/include/linux/sm501.h
@@ -173,10 +173,5 @@ struct sm501_platdata {
 	unsigned int			 gpio_i2c_nr;
 };
 
-#if defined(CONFIG_PPC32)
-#define smc501_readl(addr)		ioread32be((addr))
-#define smc501_writel(val, addr)	iowrite32be((val), (addr))
-#else
-#define smc501_readl(addr)		readl(addr)
-#define smc501_writel(val, addr)	writel(val, addr)
-#endif
+#define smc501_readl(addr)		__raw_readl(addr)
+#define smc501_writel(val, addr)	__raw_writel(val, addr)
-- 
1.7.4.1

