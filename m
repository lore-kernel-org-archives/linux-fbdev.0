From: Lad Prabhakar <prabhakar.csengg@gmail.com>
Date: Thu, 05 Feb 2015 12:54:08 +0000
Subject: [PATCH] fbdev: via/via_clock: fix sparse warning
Message-Id: <1423140848-5989-1-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch fixes following sparse warning:

via_clock.c:33:12: warning: symbol 'via_slap' was not declared. Should it be static?

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 Found this issue on linux-next (gcc  version 4.9.2,
 sparse version  0.4.5-rc1)and applies on top linux-next.

 drivers/video/fbdev/via/via_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/via_clock.c b/drivers/video/fbdev/via/via_clock.c
index db1e392..bf269fa 100644
--- a/drivers/video/fbdev/via/via_clock.c
+++ b/drivers/video/fbdev/via/via_clock.c
@@ -30,7 +30,7 @@
 #include "global.h"
 #include "debug.h"
 
-const char *via_slap = "Please slap VIA Technologies to motivate them "
+static const char *via_slap = "Please slap VIA Technologies to motivate them "
 	"releasing full documentation for your platform!\n";
 
 static inline u32 cle266_encode_pll(struct via_pll_config pll)
-- 
1.9.1

