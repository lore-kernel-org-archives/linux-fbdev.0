From: Moshe Green <mgmoshes@gmail.com>
Date: Tue, 30 Aug 2016 19:04:56 +0000
Subject: [PATCH 4/9] staging: sm750fb: fix coding style issues in ddk750_chip.c
Message-Id: <6c1db940ada71ef09b6f2d6c6c762115fbac7188.1472583825.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
In-Reply-To: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix line length and block comment * prefix warnings found
by the checkpatch.pl tool in ddk750_chip.c.

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 577a279..f15800a 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -243,9 +243,10 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 	setMasterClock(MHz(pInitParam->masterClock));
 
 
-	/* Reset the memory controller. If the memory controller is not reset in SM750,
-	   the system might hang when sw accesses the memory.
-	   The memory should be resetted after changing the MXCLK.
+	/* Reset the memory controller.
+	 * If the memory controller is not reset in SM750,
+	 * the system might hang when sw accesses the memory.
+	 * The memory should be resetted after changing the MXCLK.
 	 */
 	if (pInitParam->resetMemory = 1) {
 		reg = PEEK32(MISC_CTRL);
-- 
2.7.4

