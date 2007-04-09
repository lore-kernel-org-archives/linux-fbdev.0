From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/7] rivafb/nvidiafb: Various cleanups
Date: Mon, 09 Apr 2007 19:40:31 +0800
Message-ID: <461A262F.6000806@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HasKU-0001l2-KN for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 04:46:38 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HasKU-0002zZ-2h
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 04:46:38 -0700
Received: by py-out-1112.google.com with SMTP id a29so1005388pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Apr 2007 04:46:37 -0700 (PDT)
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
Cc: Jean Delvare <khali@linux-fr.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jean Delvare <khali@linux-fr.org>

Various cleanups to rivafb/nvidiafb's I2C code:
* Drop useless par->bus.
* Refactor I2C bus deletion code.
* Drop useless variable initialization.
* Remove unneeded include of <linux/i2c-id.h>.
* Simplify +1/-1.
* Add __devinit tags where possible.

[adaplas]
The varible initialization are not useless. However, rivafb must
check if i2c bus are created properly before reading the EDID
block.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_i2c.c   |   20 +++++++-------------
 drivers/video/nvidia/nv_type.h  |    2 --
 drivers/video/riva/fbdev.c      |    4 ++--
 drivers/video/riva/rivafb-i2c.c |   31 ++++++++++++++-----------------
 drivers/video/riva/rivafb.h     |    2 --
 5 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index 2674259..93615d2 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -127,8 +127,6 @@ static int nvidia_setup_i2c_bus(struct n
 
 void nvidia_create_i2c_busses(struct nvidia_par *par)
 {
-	par->bus = 3;
-
 	par->chan[0].par = par;
 	par->chan[1].par = par;
 	par->chan[2].par = par;
@@ -145,18 +143,14 @@ void nvidia_create_i2c_busses(struct nvi
 
 void nvidia_delete_i2c_busses(struct nvidia_par *par)
 {
-	if (par->chan[0].par)
-		i2c_del_adapter(&par->chan[0].adapter);
-	par->chan[0].par = NULL;
-
-	if (par->chan[1].par)
-		i2c_del_adapter(&par->chan[1].adapter);
-	par->chan[1].par = NULL;
-
-	if (par->chan[2].par)
-		i2c_del_adapter(&par->chan[2].adapter);
-	par->chan[2].par = NULL;
+	int i;
 
+	for (i = 0; i < 3; i++) {
+		if (!par->chan[i].par)
+			continue;
+		i2c_del_adapter(&par->chan[i].adapter);
+		par->chan[i].par = NULL;
+	}
 }
 
 int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
diff --git a/drivers/video/nvidia/nv_type.h b/drivers/video/nvidia/nv_type.h
index 86e65de..ee430af 100644
--- a/drivers/video/nvidia/nv_type.h
+++ b/drivers/video/nvidia/nv_type.h
@@ -4,7 +4,6 @@ #define __NV_TYPE_H__
 #include <linux/fb.h>
 #include <linux/types.h>
 #include <linux/i2c.h>
-#include <linux/i2c-id.h>
 #include <linux/i2c-algo-bit.h>
 
 #define NV_ARCH_04  0x04
@@ -100,7 +99,6 @@ struct nvidia_par {
 	u32 Architecture;
 	u32 CursorStart;
 	int Chipset;
-	int bus;
 	unsigned long FbAddress;
 	u8 __iomem *FbStart;
 	u32 FbMapSize;
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index b8d50f1..9e6ee1f 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1788,10 +1788,10 @@ static int __devinit riva_get_EDID_i2c(s
 
 	NVTRACE_ENTER();
 	riva_create_i2c_busses(par);
-	for (i = 0; i < par->bus; i++) {
+	for (i = 0; i < 3; i++) {
 		if (!par->chan[i].par)
 			continue;
-		riva_probe_i2c_connector(par, i+1, &par->EDID);
+		riva_probe_i2c_connector(par, i, &par->EDID);
 		if (par->EDID && !fb_parse_edid(par->EDID, &var)) {
 			printk(PFX "Found EDID Block from BUS %i\n", i);
 			break;
diff --git a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
index ca9e7e8..bcb2096 100644
--- a/drivers/video/riva/rivafb-i2c.c
+++ b/drivers/video/riva/rivafb-i2c.c
@@ -88,8 +88,9 @@ static int riva_gpio_getsda(void* data)
 	return val;
 }
 
-static int riva_setup_i2c_bus(struct riva_i2c_chan *chan, const char *name,
-			      unsigned int i2c_class)
+static int __devinit riva_setup_i2c_bus(struct riva_i2c_chan *chan,
+					const char *name,
+					unsigned int i2c_class)
 {
 	int rc;
 
@@ -126,10 +127,8 @@ static int riva_setup_i2c_bus(struct riv
 	return rc;
 }
 
-void riva_create_i2c_busses(struct riva_par *par)
+void __devinit riva_create_i2c_busses(struct riva_par *par)
 {
-	par->bus = 3;
-
 	par->chan[0].par	= par;
 	par->chan[1].par	= par;
 	par->chan[2].par        = par;
@@ -144,24 +143,22 @@ void riva_create_i2c_busses(struct riva_
 
 void riva_delete_i2c_busses(struct riva_par *par)
 {
-	if (par->chan[0].par)
-		i2c_del_adapter(&par->chan[0].adapter);
-	par->chan[0].par = NULL;
-
-	if (par->chan[1].par)
-		i2c_del_adapter(&par->chan[1].adapter);
-	par->chan[1].par = NULL;
+	int i;
 
-	if (par->chan[2].par)
-		i2c_del_adapter(&par->chan[2].adapter);
-	par->chan[2].par = NULL;
+	for (i = 0; i < 3; i++) {
+		if (!par->chan[i].par)
+			continue;
+		i2c_del_adapter(&par->chan[i].adapter);
+		par->chan[i].par = NULL;
+	}
 }
 
-int riva_probe_i2c_connector(struct riva_par *par, int conn, u8 **out_edid)
+int __devinit riva_probe_i2c_connector(struct riva_par *par, int conn, u8 **out_edid)
 {
 	u8 *edid = NULL;
 
-	edid = fb_ddc_read(&par->chan[conn-1].adapter);
+	if (par->chan[conn].par)
+		edid = fb_ddc_read(&par->chan[conn].adapter);
 
 	if (out_edid)
 		*out_edid = edid;
diff --git a/drivers/video/riva/rivafb.h b/drivers/video/riva/rivafb.h
index 48ead6d..d9f107b 100644
--- a/drivers/video/riva/rivafb.h
+++ b/drivers/video/riva/rivafb.h
@@ -4,7 +4,6 @@ #define __RIVAFB_H
 #include <linux/fb.h>
 #include <video/vga.h>
 #include <linux/i2c.h>
-#include <linux/i2c-id.h>
 #include <linux/i2c-algo-bit.h>
 
 #include "riva_hw.h"
@@ -61,7 +60,6 @@ #endif
 	Bool SecondCRTC;
 	int FlatPanel;
 	struct pci_dev *pdev;
-	int bus;
 	int cursor_reset;
 #ifdef CONFIG_MTRR
 	struct { int vram; int vram_valid; } mtrr;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
