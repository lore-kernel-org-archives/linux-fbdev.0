From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Date: Sun, 10 Jan 2010 17:04:31 +0000
Subject: [PATCH] video skeletonfb: use DEFINE_PCI_DEVICE_TABLE()
Message-Id: <4B4A089F.3090908@freemail.hu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

From: Márton Németh <nm127@freemail.hu>

Use DEFINE_PCI_DEVICE_TABLE() when declaring the PCI device
table as suggested in Documentation/PCI/pci.txt .

Signed-off-by: Márton Németh <nm127@freemail.hu>
---
--- linux/drivers/video/skeletonfb.c.orig	2009-12-03 04:51:21.000000000 +0100
+++ linux/drivers/video/skeletonfb.c	2010-01-10 17:59:55.000000000 +0100
@@ -887,7 +887,7 @@ static int xxxfb_resume(struct pci_dev *
 #define xxxfb_resume NULL
 #endif /* CONFIG_PM */

-static struct pci_device_id xxxfb_id_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(xxxfb_id_table) = {
 	{ PCI_VENDOR_ID_XXX, PCI_DEVICE_ID_XXX,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  PCI_CLASS_MASK, 0 },
