From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Aug 2012 20:41:23 +0000
Subject: [PATCH -next] HID: picoLCD: Add missing #include <linux/uaccess.h>
Message-Id: <1345581683-2099-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

m68k/allmodconfig:

drivers/hid/hid-picolcd_debugfs.c: In function ‘picolcd_debug_reset_write’:
drivers/hid/hid-picolcd_debugfs.c:54: error: implicit declaration of function ‘copy_from_user’
drivers/hid/hid-picolcd_debugfs.c: In function ‘picolcd_debug_eeprom_read’:
drivers/hid/hid-picolcd_debugfs.c:112: error: implicit declaration of function ‘copy_to_user’

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
http://kisskb.ellerman.id.au/kisskb/buildresult/6990818/

 drivers/hid/hid-picolcd_debugfs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index f2491fa..15c22f2 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -27,6 +27,7 @@
 #include <linux/debugfs.h>
 
 #include <linux/module.h>
+#include <linux/uaccess.h>
 
 #include "hid-picolcd.h"
 
-- 
1.7.0.4

