From: Max Staudt <mstaudt@suse.de>
Date: Wed, 13 Dec 2017 19:47:49 +0000
Subject: [RFC PATCH v2 07/13] vt: Add keyboard hook to disable bootsplash
Message-Id: <20171213194755.3409-8-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
In-Reply-To: <20171213194755.3409-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: michal@markovi.net, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, mstaudt@suse.de, bernhard.rosenkranzer@linaro.org, philm@manjaro.org

Let's disable the splash if the user presses ESC or F1-F12 on a VT.

The F1-F12 check is to disable the splash on VT switches.

Signed-off-by: Max Staudt <mstaudt@suse.de>
---
 drivers/tty/vt/keyboard.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index f4166263bb3a..a248429194bb 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -47,6 +47,8 @@
 
 #include <asm/irq_regs.h>
 
+#include <linux/bootsplash.h>
+
 extern void ctrl_alt_del(void);
 
 /*
@@ -1353,6 +1355,28 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 	}
 #endif
 
+	/* Trap keys when bootsplash is shown */
+	if (bootsplash_would_render_now()) {
+		/* Deactivate bootsplash on ESC or Alt+Fxx VT switch */
+		if (keycode >= KEY_F1 && keycode <= KEY_F12) {
+			bootsplash_disable();
+
+			/*
+			 * No return here since we want to actually
+			 * perform the VT switch.
+			 */
+		} else {
+			if (keycode = KEY_ESC)
+				bootsplash_disable();
+
+			/*
+			 * Just drop any other keys.
+			 * Their effect would be hidden by the splash.
+			 */
+			return;
+		}
+	}
+
 	if (kbd->kbdmode = VC_MEDIUMRAW) {
 		/*
 		 * This is extended medium raw mode, with keys above 127
-- 
2.12.3

