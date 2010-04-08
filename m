From: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 02/16] viafb: use proper pci config API
Date: Thu,  8 Apr 2010 11:15:32 -0600
Message-ID: <1270746946-12467-3-git-send-email-corbet@lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

From: Harald Welte <laforge@gnumonks.org>

This patch alters viafb to use the proper Linux in-kernel API to access
PCI configuration space, rather than poking at I/O ports by itself.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/video/via/hw.c |   64 +++++++++++++++++++++++++++++------------------
 drivers/video/via/hw.h |    4 +-
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index ea0f8ec..f2e4bda 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2542,24 +2542,37 @@ static void disable_second_display_channel(void)
 	viafb_write_reg_mask(CR6A, VIACR, BIT6, BIT6);
 }
 
+static u_int16_t via_function3[] = {
+	CLE266_FUNCTION3, KM400_FUNCTION3, CN400_FUNCTION3, CN700_FUNCTION3,
+	CX700_FUNCTION3, KM800_FUNCTION3, KM890_FUNCTION3, P4M890_FUNCTION3,
+	P4M900_FUNCTION3, VX800_FUNCTION3, VX855_FUNCTION3,
+};
+
+/* Get the BIOS-configured framebuffer size from PCI configuration space
+ * of function 3 in the respective chipset */
 int viafb_get_fb_size_from_pci(void)
 {
-	unsigned long configid, deviceid, FBSize = 0;
-	int VideoMemSize;
-	int DeviceFound = false;
-
-	for (configid = 0x80000000; configid < 0x80010800; configid += 0x100) {
-		outl(configid, (unsigned long)0xCF8);
-		deviceid = (inl((unsigned long)0xCFC) >> 16) & 0xffff;
-
-		switch (deviceid) {
-		case CLE266:
-		case KM400:
-			outl(configid + 0xE0, (unsigned long)0xCF8);
-			FBSize = inl((unsigned long)0xCFC);
-			DeviceFound = true;	/* Found device id */
-			break;
+	int i;
+	u_int8_t offset = 0;
+	u_int32_t FBSize;
+	u_int32_t VideoMemSize;
+
+	/* search for the "FUNCTION3" device in this chipset */
+	for (i = 0; i < ARRAY_SIZE(via_function3); i++) {
+		struct pci_dev *pdev;
+
+		pdev = pci_get_device(PCI_VENDOR_ID_VIA, via_function3[i],
+				      NULL);
+		if (!pdev)
+			continue;
+
+		DEBUG_MSG(KERN_INFO "Device ID = %x\n", pdev->device);
 
+		switch (pdev->device) {
+		case CLE266_FUNCTION3:
+		case KM400_FUNCTION3:
+			offset = 0xE0;
+			break;
 		case CN400_FUNCTION3:
 		case CN700_FUNCTION3:
 		case CX700_FUNCTION3:
@@ -2569,21 +2582,22 @@ int viafb_get_fb_size_from_pci(void)
 		case P4M900_FUNCTION3:
 		case VX800_FUNCTION3:
 		case VX855_FUNCTION3:
-			/*case CN750_FUNCTION3: */
-			outl(configid + 0xA0, (unsigned long)0xCF8);
-			FBSize = inl((unsigned long)0xCFC);
-			DeviceFound = true;	/* Found device id */
-			break;
-
-		default:
+		/*case CN750_FUNCTION3: */
+			offset = 0xA0;
 			break;
 		}
-
-		if (DeviceFound)
+		
+		if (!offset)
 			break;
+
+		pci_read_config_dword(pdev, offset, &FBSize);
+		pci_dev_put(pdev);
 	}
 
-	DEBUG_MSG(KERN_INFO "Device ID = %lx\n", deviceid);
+	if (!offset) {
+		printk(KERN_ERR "cannot determine framebuffer size\n");
+		return -EIO;
+	}
 
 	FBSize = FBSize & 0x00007000;
 	DEBUG_MSG(KERN_INFO "FB Size = %x\n", FBSize);
diff --git a/drivers/video/via/hw.h b/drivers/video/via/hw.h
index b874d95..f67a56a 100644
--- a/drivers/video/via/hw.h
+++ b/drivers/video/via/hw.h
@@ -822,8 +822,8 @@ struct iga2_crtc_timing {
 };
 
 /* device ID */
-#define CLE266              0x3123
-#define KM400               0x3205
+#define CLE266_FUNCTION3    0x3123
+#define KM400_FUNCTION3     0x3205
 #define CN400_FUNCTION2     0x2259
 #define CN400_FUNCTION3     0x3259
 /* support VT3314 chipset */
-- 
1.7.0.1
