From: Moshe Green <mgmoshes@gmail.com>
Date: Tue, 30 Aug 2016 19:04:02 +0000
Subject: [PATCH 1/9] staging: sm750fb: fix line length coding style issue in ddk750_chip.c
Message-Id: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix a line length warning found by the checkpatch.pl tool in
ddk750_chip.c.

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index c1356bb..fb27eb4 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -71,7 +71,7 @@ static void setChipClock(unsigned int frequency)
 		pll.clockType = MXCLK_PLL;
 
 		/*
-		* Call calcPllValue() to fill up the other fields for PLL structure.
+		* Call calcPllValue() to fill the other fields of PLL structure.
 		* Sometime, the chip cannot set up the exact clock required by User.
 		* Return value from calcPllValue() gives the actual possible clock.
 		*/
-- 
2.7.4

