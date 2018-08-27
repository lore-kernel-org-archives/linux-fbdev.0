From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Mon, 27 Aug 2018 16:05:42 +0000
Subject: [PATCH v2] drivers/video/fbdev: use ioremap_wc() instead of __ioremap(_PAGE_NO_CACHE)
Message-Id: <19880223194e682a895f6685f6ae2c18994fd774.1535385164.git.christophe.leroy@c-s.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

_PAGE_NO_CACHE is a target specific flag. In addition, this flag
is misleading because one would think it requests a noncached page
whereas a noncached page is _PAGE_NO_CACHE | _PAGE_GUARDED

_PAGE_NO_CACHE alone means write combined noncached page, so lets
use ioremap_wc() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: removed unnecessary include and enhanced commit log follow Segher's comment

 drivers/video/fbdev/chipsfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index f103665cad43..40182ed85648 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/console.h>
-#include <asm/io.h>
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
@@ -401,7 +400,7 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
 #ifdef CONFIG_PPC
-	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
+	p->screen_base = ioremap_wc(addr, 0x200000);
 #else
 	p->screen_base = ioremap(addr, 0x200000);
 #endif
-- 
2.13.3
