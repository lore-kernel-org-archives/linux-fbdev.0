From: Paul Bolle <pebolle@tiscali.nl>
Date: Wed, 13 Jun 2012 07:47:31 +0000
Subject: [PATCH] video: backlight: remove unused header
Message-Id: <1339573651.30984.130.camel@x61.thuisdomein>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 9befe40f6e018e508b047eb76d189ede9b4ff03d ("video: backlight:
support s6e8ax0 panel driver based on MIPI DSI") added s6e8ax0.h, but
no file includes it. That's probably a good thing, because it declares
an extern void function that is defined static int in s6e8ax0.c.
Besides, that function is also wrapped in the module_init() macro, which
should do everything needed to make that function available to the code
outside of s6e8ax0.c. This header can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Tested mainly by using various git tools on the (history of the)
tree.

1) Shouldn't s6e8ax0_init() and s6e8ax0_exit(), both in s6e8ax0.c, carry
the usual __init and __exit attributes?

2) But note that all the module related code in s6e8ax0.c seems moot
currently: EXYNOS_LCD_S6E8AX0 is a boolean Kconfig symbol, so the code
can only be used builtin. So, as far as I can tell, either that symbol
(and the symbols on which it depends) should be made tristate, or the
module related code can be removed from s6e8ax0.c.

 drivers/video/exynos/s6e8ax0.h |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)
 delete mode 100644 drivers/video/exynos/s6e8ax0.h

diff --git a/drivers/video/exynos/s6e8ax0.h b/drivers/video/exynos/s6e8ax0.h
deleted file mode 100644
index 1f1b270..0000000
--- a/drivers/video/exynos/s6e8ax0.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* linux/drivers/video/backlight/s6e8ax0.h
- *
- * MIPI-DSI based s6e8ax0 AMOLED LCD Panel definitions.
- *
- * Copyright (c) 2011 Samsung Electronics
- *
- * Inki Dae, <inki.dae@samsung.com>
- * Donghwa Lee <dh09.lee@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef _S6E8AX0_H
-#define _S6E8AX0_H
-
-extern void s6e8ax0_init(void);
-
-#endif
-
-- 
1.7.7.6

