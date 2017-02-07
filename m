From: Matthieu Simon <gmatthsim@gmail.com>
Date: Tue, 07 Feb 2017 19:11:22 +0000
Subject: [PATCH] staging: sm750fb: Enclose macro arguments in parentheses
Message-Id: <ca24586f16d0a9ff4d5882156e358600e94fd71c.1486493982.git.gmatthsim@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

checkpatch noticed possible precedence issues resulting in the definition
of PEEK32 and POKE32. So, these arguments should be enclosed in
parentheses.

Signed-off-by: Matthieu Simon <gmatthsim@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index e63b8b293816..a5f910344373 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -10,8 +10,8 @@
 #include <linux/uaccess.h>
 
 /* software control endianness */
-#define PEEK32(addr) readl(addr + mmio750)
-#define POKE32(addr, data) writel(data, addr + mmio750)
+#define PEEK32(addr) readl((addr) + mmio750)
+#define POKE32(addr, data) writel((data), (addr) + mmio750)
 
 extern void __iomem *mmio750;
 
-- 
Matthieu

