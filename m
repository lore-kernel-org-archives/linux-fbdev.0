From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 2.6.19 7/6] tgafb: Fix the PCI ID table
Date: Thu, 14 Dec 2006 13:56:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64N.0612141349590.12201@blysk.ds.pg.gda.pl>
Reply-To: Linux on Alpha processors <axp-list@redhat.com>
Mime-Version: 1.0
Return-path: <axp-list-bounces@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/axp-list>
List-Post: <mailto:axp-list@redhat.com>
List-Help: <mailto:axp-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=subscribe>
Sender: axp-list-bounces@redhat.com
Errors-To: axp-list-bounces@redhat.com
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: axp-list@redhat.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

 The end marker is missing from the driver's PCI ID table.  This set of 
changes adds the marker, switches to using PCI_DEVICE() and records the 
table for the use in a module.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Here's one more. ;-)

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-pci_tbl-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-14 00:55:35.000000000 +0000
@@ -69,9 +69,10 @@ static struct fb_ops tgafb_ops = {
  */
 
 static struct pci_device_id const tgafb_pci_table[] = {
-	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA, PCI_ANY_ID, PCI_ANY_ID,
-	  0, 0, 0 }
+	{ PCI_DEVICE(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA) },
+	{ }
 };
+MODULE_DEVICE_TABLE(pci, tgafb_pci_table);
 
 static struct pci_driver tgafb_driver = {
 	.name			= "tgafb",
