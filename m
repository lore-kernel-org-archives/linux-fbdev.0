From: Manav Batra <batmanav10@gmail.com>
Date: Fri, 29 Apr 2016 09:15:50 +0000
Subject: [PATCH] staging: sm750fb: Removed multiple blank lines
Message-Id: <20160429091550.GA6188@iiitd.ac.in>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org

Signed-off-by: Manav Batra <batmanav10@gmail.com>

Removes multiple blank lines.
---
 drivers/staging/sm750fb/ddk750_power.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index b3c3791..5d92a09 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -24,7 +24,6 @@ static unsigned int getPowerMode(void)
 	return PEEK32(POWER_MODE_CTRL) & POWER_MODE_CTRL_MODE_MASK;
 }
 
-
 /*
  * SM50x can operate in one of three modes: 0, 1 or Sleep.
  * On hardware reset, power mode 0 is default.
@@ -97,7 +96,6 @@ void setCurrentGate(unsigned int gate)
 }
 
 
-
 /*
  * This function enable/disable the 2D engine.
  */
@@ -162,4 +160,3 @@ void enableI2C(unsigned int enable)
 	setCurrentGate(gate);
 }
 
-
-- 
1.9.1

