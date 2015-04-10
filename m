From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 10 Apr 2015 22:03:19 +0000
Subject: [PATCH] staging: sm750: remove incorrect __exit annotation
Message-Id: <3220041.yyKr7PMSXS@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The lynxfb_pci_remove function is used as the 'remove' callback
of the driver, and must not be discarded:

lynxfb_pci_remove' referenced in section `.data' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o

This removes the extraneous annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3c7ea95dd9f9..dbbb2f879a29 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1250,7 +1250,7 @@ err_enable:
 	return -ENODEV;
 }
 
-static void __exit lynxfb_pci_remove(struct pci_dev *pdev)
+static void lynxfb_pci_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info;
 	struct lynx_share *share;

