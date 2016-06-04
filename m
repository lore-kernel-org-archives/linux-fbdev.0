From: Mikulas Tomanka <mklstmnk@gmail.com>
Date: Sat, 04 Jun 2016 08:43:32 +0000
Subject: [PATCH] staging: sm750fb: deleted couple of blank lines at the very end
Message-Id: <20160604104218.18806-1-mklstmnk@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Mikulas Tomanka <mklstmnk@gmail.com>

Signed-off-by: Mikulas Tomanka <mklstmnk@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f80ee77..5e2d6d2 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -383,5 +383,3 @@ unsigned int formatPllReg(pll_value_t *pPLL)
 
 	return reg;
 }
-
-
-- 
2.8.3

