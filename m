From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 02 Jul 2013 06:28:21 +0000
Subject: [patch -next] fb: fix recent breakage in correct_chipset()
Message-Id: <20130702062821.GC24410@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The 6e36308a6f "fb: fix atyfb build warning" isn't right.  It makes all
the indexes off by one.  This patch reverts it and casts the
ARRAY_SIZE() to int to silence the build warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index a89c15d..9b0f12c 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -435,8 +435,8 @@ static int correct_chipset(struct atyfb_par *par)
 	const char *name;
 	int i;
 
-	for (i = ARRAY_SIZE(aty_chips); i > 0; i--)
-		if (par->pci_id = aty_chips[i - 1].pci_id)
+	for (i = (int)ARRAY_SIZE(aty_chips) - 1; i >= 0; i--)
+		if (par->pci_id = aty_chips[i].pci_id)
 			break;
 
 	if (i < 0)
