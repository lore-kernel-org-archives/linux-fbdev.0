From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 27 Mar 2012 03:15:56 +0000
Subject: [PATCH] video: pxa3xx-gcu: Simplify the logic to exit while loop in pxa3xx_gcu_wait_idle
Message-Id: <1332818156.21855.4.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>, Sven Neumann <s.neumann@raumfeld.com>, Janine Kropp <nin@directfb.org>, Denis Oliver Kropp <dok@directfb.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

If wait_event_interruptible_timeout returns a positive value, it means
the condition evaluated is true. Which means priv->shared->hw_running is false.
And then we will exit the loop.

This patch simplifies the logic to exit the while loop.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/pxa3xx-gcu.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index 1d71c08..0b4ae0c 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -316,12 +316,9 @@ pxa3xx_gcu_wait_idle(struct pxa3xx_gcu_priv *priv)
 		ret = wait_event_interruptible_timeout(priv->wait_idle,
 					!priv->shared->hw_running, HZ*4);
 
-		if (ret < 0)
+		if (ret != 0)
 			break;
 
-		if (ret > 0)
-			continue;
-
 		if (gc_readl(priv, REG_GCRBEXHR) = rbexhr &&
 		    priv->shared->num_interrupts = num) {
 			QERROR("TIMEOUT");
-- 
1.7.5.4



