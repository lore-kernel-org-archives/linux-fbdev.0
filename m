From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 38/41] pm2fb: 3dlabs Permedia 2V
	reference board added
Date: Wed, 25 Apr 2007 15:22:31 +0800
Message-ID: <462F01B7.8050302@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcDp-0001mE-UR for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:47:30 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcDp-0007z9-Il
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:47:29 -0700
Received: by py-out-1112.google.com with SMTP id a29so117820pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:47:29 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds support for 3dlabs Permedia reference board.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index a560a22..2c7dccb 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1117,20 +1117,31 @@ #endif
 		default_par->mem_control, default_par->boot_address,
 		default_par->mem_config);
 
+	default_par->memclock = CVPPC_MEMCLOCK;
 	if(default_par->mem_control == 0 &&
 		default_par->boot_address == 0x31 &&
-		default_par->mem_config == 0x259fffff &&
-		pdev->subsystem_vendor == 0x1048 &&
-		pdev->subsystem_device == 0x0a31) {
-		DPRINTK("subsystem_vendor: %04x, subsystem_device: %04x\n",
-			pdev->subsystem_vendor, pdev->subsystem_device);
-		DPRINTK("We have not been initialized by VGA BIOS "
-			"and are running on an Elsa Winner 2000 Office\n");
-		DPRINTK("Initializing card timings manually...\n");
+		default_par->mem_config == 0x259fffff) {
 		default_par->mem_control=0;
 		default_par->boot_address=0x20;
 		default_par->mem_config=0xe6002021;
-		default_par->memclock=100000;
+		if (pdev->subsystem_vendor == 0x1048 &&
+			pdev->subsystem_device == 0x0a31) {
+			DPRINTK("subsystem_vendor: %04x, subsystem_device: %04x\n",
+				pdev->subsystem_vendor, pdev->subsystem_device);
+			DPRINTK("We have not been initialized by VGA BIOS "
+				"and are running on an Elsa Winner 2000 Office\n");
+			DPRINTK("Initializing card timings manually...\n");
+			default_par->memclock=70000;
+		}
+		if (pdev->subsystem_vendor == 0x3d3d &&
+			pdev->subsystem_device == 0x0100) {
+			DPRINTK("subsystem_vendor: %04x, subsystem_device: %04x\n",
+				pdev->subsystem_vendor, pdev->subsystem_device);
+			DPRINTK("We have not been initialized by VGA BIOS "
+				"and are running on an 3dlabs reference board\n");
+			DPRINTK("Initializing card timings manually...\n");
+			default_par->memclock=70000;
+		}
 	}
 
 	/* Now work out how big lfb is going to be. */
@@ -1148,7 +1159,6 @@ #endif
 		default_par->fb_size=0x800000;
 		break;
 	}
-	default_par->memclock = CVPPC_MEMCLOCK;
 	pm2fb_fix.smem_start = pci_resource_start(pdev, 1);
 	pm2fb_fix.smem_len = default_par->fb_size;
 
@@ -1242,6 +1252,9 @@ static struct pci_device_id pm2fb_id_tab
 	{ PCI_VENDOR_ID_3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2V,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
+	{ PCI_VENDOR_ID_3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2V,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NOT_DEFINED_VGA << 8,
+	  0xff00, 0 },
 	{ 0, }
 };
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
