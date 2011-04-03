From: Christian Schmidt <charlie@digadd.de>
Date: Sun, 03 Apr 2011 20:48:28 +0000
Subject: PATCH: New Matrox PCI ID
Message-Id: <4D98DD1C.4080300@digadd.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030505010605070609020100"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

This is a multi-part message in MIME format.
--------------030505010605070609020100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

The attached patch adds the PCI ID for the Matrox G200eW. Console
Framebuffer selection via video= parameter works.

Regards,
Christian

--------------030505010605070609020100
Content-Type: text/plain;
 name="matrox.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="matrox.patch"

diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index a082deb..0461dd4 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -1468,6 +1468,13 @@ static struct board {
 		MGA_G200,
 		&vbG200,
 		"MGA-G200eV (PCI)"},
+	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200EW_PCI,	0xFF,
+		0,			0,
+		DEVF_G200,
+		230000,
+		MGA_G200,
+		&vbG200,
+		"MGA-G200eW (PCI)"},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_PCI,	0xFF,
 		0,			0,
 		DEVF_G200,
@@ -2121,6 +2128,8 @@ static struct pci_device_id matroxfb_devices[] = {
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200EV_PCI,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
+	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200EW_PCI,
+		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_PCI,
 		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_AGP,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 3adb06e..b80877e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -604,6 +604,7 @@
 #define PCI_DEVICE_ID_MATROX_G200_AGP	0x0521
 #define	PCI_DEVICE_ID_MATROX_G400	0x0525
 #define	PCI_DEVICE_ID_MATROX_G200EV_PCI	0x0530
+#define PCI_DEVICE_ID_MATROX_G200EW_PCI 0x0532
 #define PCI_DEVICE_ID_MATROX_G550	0x2527
 #define PCI_DEVICE_ID_MATROX_VIA	0x4536
 

--------------030505010605070609020100--
