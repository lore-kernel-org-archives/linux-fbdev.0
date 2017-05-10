From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:55 +0000
Subject: [PATCH 5/9] staging: sm750fb: Remove typedef from "typedef enum _logical_chip_type_t"
Message-Id: <1494453359-3722-6-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch removes typedefs from enum and renames it from "typedef enum
_logical_chip_type_t" to "enum logical_chip_type" as per kernel coding
standards.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/ddk750_chip.c | 4 ++--
 drivers/staging/sm750fb/ddk750_chip.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 944dd25..1d62c2d 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -7,9 +7,9 @@
 
 #define MHz(x) ((x) * 1000000)
 
-static logical_chip_type_t chip;
+static enum logical_chip_type chip;
 
-logical_chip_type_t sm750_get_chip_type(void)
+enum logical_chip_type sm750_get_chip_type(void)
 {
 	return chip;
 }
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 2c7a9b9..f2eee2b 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -23,13 +23,13 @@ static inline void poke32(u32 data, u32 addr)
 }
 
 /* This is all the chips recognized by this library */
-typedef enum _logical_chip_type_t {
+enum logical_chip_type {
 	SM_UNKNOWN,
 	SM718,
 	SM750,
 	SM750LE,
-}
-logical_chip_type_t;
+};
+
 
 typedef enum _clock_type_t {
 	MXCLK_PLL,
@@ -93,7 +93,7 @@ struct initchip_param {
 	/* More initialization parameter can be added if needed */
 };
 
-logical_chip_type_t sm750_get_chip_type(void);
+enum logical_chip_type sm750_get_chip_type(void);
 void sm750_set_chip_type(unsigned short devId, u8 revId);
 unsigned int sm750_calc_pll_value(unsigned int request, struct  pll_value *pll);
 unsigned int sm750_format_pll_reg(struct pll_value *pPLL);
-- 
1.8.3.1

