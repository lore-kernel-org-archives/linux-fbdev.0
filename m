From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 20 Jun 2013 02:38:13 +0000
Subject: [PATCH 1/2] fb: fix atyfb build warning
Message-Id: <51C26B15.3090800@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build warning when neither of CONFIG_FB_ATY_GX or
CONFIG_FB_ATY_CT is enabled, since ARRAY_SIZE(aty_chips) is 0 in
that case.

drivers/video/aty/atyfb_base.c:437:11: warning: overflow in implicit constant conversion [-Woverflow]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Paul Mackerras <paulus@samba.org>
Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:	linux-fbdev@vger.kernel.org
Cc:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc:	Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/aty/atyfb_base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20130619.orig/drivers/video/aty/atyfb_base.c
+++ linux-next-20130619/drivers/video/aty/atyfb_base.c
@@ -434,8 +434,8 @@ static int correct_chipset(struct atyfb_
 	const char *name;
 	int i;
 
-	for (i = ARRAY_SIZE(aty_chips) - 1; i >= 0; i--)
-		if (par->pci_id = aty_chips[i].pci_id)
+	for (i = ARRAY_SIZE(aty_chips); i > 0; i--)
+		if (par->pci_id = aty_chips[i - 1].pci_id)
 			break;
 
 	if (i < 0)
