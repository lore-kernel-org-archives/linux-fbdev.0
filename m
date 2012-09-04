From: Daniel Drake <dsd@laptop.org>
Date: Tue, 04 Sep 2012 15:45:32 +0000
Subject: [PATCH] viafb: don't touch clock state on OLPC XO-1.5
Message-Id: <20120904154533.1DC4AFAA0F@dev.laptop.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

As detailed in the thread titled "viafb PLL/clock tweaking causes XO-1.5
instability," enabling or disabling the IGA1/IGA2 clocks causes occasional
stability problems during suspend/resume cycles on this platform.

This is rather odd, as the documentation suggests that clocks have two
states (on/off) and the default (stable) configuration is configured to
enable the clock only when it is needed. However, explicitly enabling *or*
disabling the clock triggers this system instability, suggesting that there
is a 3rd state at play here.

Leaving the clock enable/disable registers alone solves this problem.
This fixes spurious reboots during suspend/resume behaviour introduced by
commit b692a63a.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/via/via_clock.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/via/via_clock.c b/drivers/video/via/via_clock.c
index af8f26b..db1e392 100644
--- a/drivers/video/via/via_clock.c
+++ b/drivers/video/via/via_clock.c
@@ -25,6 +25,7 @@
 
 #include <linux/kernel.h>
 #include <linux/via-core.h>
+#include <asm/olpc.h>
 #include "via_clock.h"
 #include "global.h"
 #include "debug.h"
@@ -289,6 +290,10 @@ static void dummy_set_pll(struct via_pll_config config)
 	printk(KERN_INFO "Using undocumented set PLL.\n%s", via_slap);
 }
 
+static void noop_set_clock_state(u8 state)
+{
+}
+
 void via_clock_init(struct via_clock *clock, int gfx_chip)
 {
 	switch (gfx_chip) {
@@ -346,4 +351,18 @@ void via_clock_init(struct via_clock *clock, int gfx_chip)
 		break;
 
 	}
+
+	if (machine_is_olpc()) {
+		/* The OLPC XO-1.5 cannot suspend/resume reliably if the
+		 * IGA1/IGA2 clocks are set as on or off (memory rot
+		 * occasionally happens during suspend under such
+		 * configurations).
+		 *
+		 * The only known stable scenario is to leave this bits as-is,
+		 * which in their default states are documented to enable the
+		 * clock only when it is needed.
+		 */
+		clock->set_primary_clock_state = noop_set_clock_state;
+		clock->set_secondary_clock_state = noop_set_clock_state;
+	}
 }
-- 
1.7.11.4

