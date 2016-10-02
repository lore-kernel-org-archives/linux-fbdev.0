From: Moshe Green <mgmoshes@gmail.com>
Date: Sun, 02 Oct 2016 11:04:46 +0000
Subject: [PATCH] staging: sm750fb: replace roundedDiv with DIV_ROUND_CLOSEST
Message-Id: <40d305d6c803600d5b78b792423f4618587229ec.1475406094.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Replace local implementation of rounded division (roundedDiv macro) with
the in-kernel implementation (DIV_ROUND_CLOSEST macro) in ddk750_chip.c

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 3a0afe1..839d673 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -6,8 +6,6 @@
 #include "ddk750_chip.h"
 #include "ddk750_power.h"
 
-/* n / d + 1 / 2 = (2n + d) / 2d */
-#define roundedDiv(num, denom)	((2 * (num) + (denom)) / (2 * (denom)))
 #define MHz(x) ((x) * 1000000)
 
 logical_chip_type_t sm750_get_chip_type(void)
@@ -102,7 +100,7 @@ static void setMemoryClock(unsigned int frequency)
 			frequency = MHz(336);
 
 		/* Calculate the divisor */
-		divisor = roundedDiv(get_mxclk_freq(), frequency);
+		divisor = DIV_ROUND_CLOSEST(get_mxclk_freq(), frequency);
 
 		/* Set the corresponding divisor in the register. */
 		reg = PEEK32(CURRENT_GATE) & ~CURRENT_GATE_M2XCLK_MASK;
@@ -152,7 +150,7 @@ static void setMasterClock(unsigned int frequency)
 			frequency = MHz(190);
 
 		/* Calculate the divisor */
-		divisor = roundedDiv(get_mxclk_freq(), frequency);
+		divisor = DIV_ROUND_CLOSEST(get_mxclk_freq(), frequency);
 
 		/* Set the corresponding divisor in the register. */
 		reg = PEEK32(CURRENT_GATE) & ~CURRENT_GATE_MCLK_MASK;
-- 
2.7.4

