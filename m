From: Axel Lin <axel.lin@gmail.com>
Date: Mon, 07 Mar 2011 08:26:13 +0000
Subject: [PATCH] video: add MODULE_DEVICE_TABLE
Message-Id: <1299486373.20702.1.camel@mola>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Ghozlane Toumi <gtoumi@laposte.net>, "David S. Miller" <davem@davemloft.net>, Alan Hourihane <alanh@tungstengraphics.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

The device table is required to load modules based on modaliases.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Ghozlane Toumi <gtoumi@laposte.net>
Cc: David S. Miller <davem@davemloft.net>
Cc: Alan Hourihane <alanh@tungstengraphics.com>
---
 drivers/video/sstfb.c               |    1 +
 drivers/video/sunxvr2500.c          |    1 +
 drivers/video/sunxvr500.c           |    1 +
 drivers/video/vermilion/vermilion.c |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index 2ab7041..597e80b 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -1485,6 +1485,7 @@ static const struct pci_device_id sstfb_id_tbl[] = {
 		.driver_data = ID_VOODOO2, },
 	{ 0 },
 };
+MODULE_DEVICE_TABLE(pci, sstfb_id_tbl);
 
 static struct pci_driver sstfb_driver = {
 	.name		= "sstfb",
diff --git a/drivers/video/sunxvr2500.c b/drivers/video/sunxvr2500.c
index 5848436..a83bc42 100644
--- a/drivers/video/sunxvr2500.c
+++ b/drivers/video/sunxvr2500.c
@@ -244,6 +244,7 @@ static struct pci_device_id s3d_pci_table[] = {
 	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0033),	},
 	{ 0, }
 };
+MODULE_DEVICE_TABLE(pci, s3d_pci_table);
 
 static struct pci_driver s3d_driver = {
 	.name		= "s3d",
diff --git a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
index b9c2b94..19e0395 100644
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -428,6 +428,7 @@ static struct pci_device_id e3d_pci_table[] = {
 	},
 	{ 0, }
 };
+MODULE_DEVICE_TABLE(pci, e3d_pci_table);
 
 static struct pci_driver e3d_driver = {
 	.name		= "e3d",
diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index 931a567..30bd156 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -1057,6 +1057,7 @@ static struct pci_device_id vml_ids[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, VML_DEVICE_VDC)},
 	{0}
 };
+MODULE_DEVICE_TABLE(pci, vml_ids);
 
 static struct pci_driver vmlfb_pci_driver = {
 	.name = "vmlfb",
-- 
1.7.2



