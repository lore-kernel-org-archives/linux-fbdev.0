From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Jul 2010 15:39:20 +0000
Subject: [PATCH 05/11] viafb: fix PCI table
Message-Id: <1279899566-4359-6-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>, Jonathan Corbet <corbet@lwn.net>, Harald Welte <laforge@gnumonks.org>

viafb: fix PCI table

This patch fixes an oddity in the device table where the P4M890 ID was
assigned with the enumeration value of CN700 which itself was missing.
This is a regression introduced by
	"viafb: make viafb a first-class citizen using pci_driver"

While at it reorder the table to reflect the order of the  enumeration
values.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Harald Welte <laforge@gnumonks.org>
---
 drivers/video/via/via-core.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index e8cfe83..4afa3c5 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -613,22 +613,24 @@ static void __devexit via_pci_remove(struct pci_dev *pdev)
 static struct pci_device_id via_pci_table[] __devinitdata = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_CLE266_DID),
 	  .driver_data = UNICHROME_CLE266 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_PM800_DID),
-	  .driver_data = UNICHROME_PM800 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_K400_DID),
 	  .driver_data = UNICHROME_K400 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_K800_DID),
 	  .driver_data = UNICHROME_K800 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_P4M890_DID),
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_PM800_DID),
+	  .driver_data = UNICHROME_PM800 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_CN700_DID),
 	  .driver_data = UNICHROME_CN700 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_K8M890_DID),
-	  .driver_data = UNICHROME_K8M890 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_CX700_DID),
 	  .driver_data = UNICHROME_CX700 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_P4M900_DID),
-	  .driver_data = UNICHROME_P4M900 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_CN750_DID),
 	  .driver_data = UNICHROME_CN750 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_K8M890_DID),
+	  .driver_data = UNICHROME_K8M890 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_P4M890_DID),
+	  .driver_data = UNICHROME_P4M890 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_P4M900_DID),
+	  .driver_data = UNICHROME_P4M900 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_VX800_DID),
 	  .driver_data = UNICHROME_VX800 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_VX855_DID),
-- 
1.6.3.2

