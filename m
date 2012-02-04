From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:41:48 +0000
Subject: [PATCH 11/13] FB: sa1100: make GPIO configuration setting safe
Message-Id: <E1Rtc7w-0000b2-Ur@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The sa1100fb driver needs to set the GPIO direction and alternate
function register according to the panel that we're driving.  We've
done this in the driver by read-modify-writing the register, which
may cause problems with races.  Fix this with a minimal change.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index d1d97ca..b644f0f 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -761,8 +761,19 @@ static void sa1100fb_setup_gpio(struct sa1100fb_info *fbi)
 	}
 
 	if (mask) {
+		unsigned long flags;
+
+		/*
+		 * SA-1100 requires the GPIO direction register set
+		 * appropriately for the alternate function.  Hence
+		 * we set it here via bitmask rather than excessive
+		 * fiddling via the GPIO subsystem - and even then
+		 * we'll still have to deal with GAFR.
+		 */
+		local_irq_save(flags);
 		GPDR |= mask;
 		GAFR |= mask;
+		local_irq_restore(flags);
 	}
 }
 
-- 
1.7.4.4

