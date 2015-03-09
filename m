From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Mon, 09 Mar 2015 20:57:08 +0000
Subject: [PATCH] staging: sm750fb: Fix sparse warning
Message-Id: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch fixes the following sparse warning:-

drivers/staging/sm750fb/ddk750_help.c: warning: incorrect type in assignment (different address spaces)

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.h | 4 +++-
 drivers/staging/sm750fb/ddk750_help.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 1c78875..a4e5bcc 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -3,6 +3,8 @@
 #define DEFAULT_INPUT_CLOCK 14318181 /* Default reference clock */
 #define SM750LE_REVISION_ID (char)0xfe
 
+#include <asm/io.h>
+
 /* This is all the chips recognized by this library */
 typedef enum _logical_chip_type_t
 {
@@ -70,7 +72,7 @@ logical_chip_type_t getChipType(void);
 unsigned int calcPllValue(unsigned int request,pll_value_t *pll);
 unsigned int calcPllValue2(unsigned int,pll_value_t *);
 unsigned int formatPllReg(pll_value_t *pPLL);
-void ddk750_set_mmio(volatile unsigned char *,unsigned short,char);
+void ddk750_set_mmio(volatile unsigned char __iomem *,unsigned short,char);
 unsigned int ddk750_getVMSize(void);
 int ddk750_initHw(initchip_param_t *);
 unsigned int getPllValue(clock_type_t clockType, pll_value_t *pPLL);
diff --git a/drivers/staging/sm750fb/ddk750_help.c b/drivers/staging/sm750fb/ddk750_help.c
index cc00d2b..6ad4dec 100644
--- a/drivers/staging/sm750fb/ddk750_help.c
+++ b/drivers/staging/sm750fb/ddk750_help.c
@@ -7,7 +7,7 @@ char revId750 = 0;
 unsigned short devId750 = 0;
 
 /* after driver mapped io registers, use this function first */
-void ddk750_set_mmio(volatile unsigned char * addr,unsigned short devId,char revId)
+void ddk750_set_mmio(volatile unsigned char __iomem * addr,unsigned short devId,char revId)
 {
 	mmio750 = addr;
 	devId750 = devId;
-- 
2.3.2

