From: Lynn Lei <lynnl.wit@gmail.com>
Date: Mon, 03 Jul 2017 08:13:15 +0000
Subject: [PATCH v2] staging: sm750fb: fixed a assignment typo
Message-Id: <20170703081315.GA1115@lynnl.wit>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

fixed a typo issue in get_mxclk_freq().

the original code using PLL_CTRL_M_SHIFT for shifting to set N flag.
which is not right, it should be PLL_CTRL_N_SHIFT.

both PLL_CTRL_M_SHIFT and PLL_CTRL_N_SHIFT
  defined in drivers/staging/sm750fb/ddk750_reg.h

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 5e4bfb601cea..c51761221131 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -40,7 +40,7 @@ static unsigned int get_mxclk_freq(void)
 
 	pll_reg = peek32(MXCLK_PLL_CTRL);
 	M = (pll_reg & PLL_CTRL_M_MASK) >> PLL_CTRL_M_SHIFT;
-	N = (pll_reg & PLL_CTRL_N_MASK) >> PLL_CTRL_M_SHIFT;
+	N = (pll_reg & PLL_CTRL_N_MASK) >> PLL_CTRL_N_SHIFT;
 	OD = (pll_reg & PLL_CTRL_OD_MASK) >> PLL_CTRL_OD_SHIFT;
 	POD = (pll_reg & PLL_CTRL_POD_MASK) >> PLL_CTRL_POD_SHIFT;
 
-- 
2.13.2

