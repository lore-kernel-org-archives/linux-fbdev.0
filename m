From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:45:55 +0000
Subject: [RFC 07/14] bootsplash: Add VT keyboard hook
Message-Id: <20171025124602.28292-8-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

Let's disable the splash if the user presses ESC or F1-F12 on a VT.

The F1-F12 check is to disable the splash on VT switches.

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/tty/vt/keyboard.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index f4166263bb3a..177b35182b7c 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -47,6 +47,8 @@
 
 #include <asm/irq_regs.h>
 
+#include <linux/bootsplash.h>
+
 extern void ctrl_alt_del(void);
 
 /*
@@ -1353,6 +1355,15 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 	}
 #endif
 
+	/* Deactivate bootsplash on ESC or Alt+Fxx VT switch */
+	if (((keycode >= KEY_F1 && keycode <= KEY_F12) || keycode = KEY_ESC)
+	    && bootsplash_is_enabled()) {
+		bootsplash_disable();
+
+		if (keycode = KEY_ESC)
+			return;
+	}
+
 	if (kbd->kbdmode = VC_MEDIUMRAW) {
 		/*
 		 * This is extended medium raw mode, with keys above 127
-- 
2.12.3

