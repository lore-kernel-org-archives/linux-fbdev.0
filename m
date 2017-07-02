From: Lynn Lei <lynnl.wit@gmail.com>
Date: Sun, 02 Jul 2017 12:24:26 +0000
Subject: [PATCH] staging: sm750fb: refactor the clock frequency calculation method
Message-Id: <20170702122426.GA17561@lynnl.wit>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

speed up calculation by merging two divisions into one.

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index c51761221131..5970c3792f27 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -44,7 +44,7 @@ static unsigned int get_mxclk_freq(void)
 	OD = (pll_reg & PLL_CTRL_OD_MASK) >> PLL_CTRL_OD_SHIFT;
 	POD = (pll_reg & PLL_CTRL_POD_MASK) >> PLL_CTRL_POD_SHIFT;
 
-	return DEFAULT_INPUT_CLOCK * M / N / (1 << OD) / (1 << POD);
+	return DEFAULT_INPUT_CLOCK * M / N / (1 << (OD + POD));
 }
 
 /*
-- 
2.13.2

