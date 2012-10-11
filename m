From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 11 Oct 2012 00:38:52 +0000
Subject: [PATCH] gbefb: fix compile error
Message-Id: <1349915932-3598-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <505B9196.3040203@gmx.de>
In-Reply-To: <505B9196.3040203@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Damien Cassou <damien.cassou@lifl.fr>

The patch "drivers/video/gbefb.c: use devm_ functions" caused a
compile error.

drivers/video/gbefb.c:1159:16: error: implicit declaration of function
'devm_ioremap' [-Werror=implicit-function-declaration]
drivers/video/gbefb.c:1179:3: error: implicit declaration of function
'devm_ioremap_nocache' [-Werror=implicit-function-declaration]

Fix it by including linux/io.h which defines those functions.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Damien Cassou <damien.cassou@lifl.fr>
---
 drivers/video/gbefb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index 9b79d38..8dc1f7a 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/io.h>
 
 #ifdef CONFIG_X86
 #include <asm/mtrr.h>
@@ -28,7 +29,6 @@
 #include <asm/addrspace.h>
 #endif
 #include <asm/byteorder.h>
-#include <asm/io.h>
 #include <asm/tlbflush.h>
 
 #include <video/gbe.h>
-- 
1.7.10.4

