From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/9] fbdev: Cleanup i2c code of rivafb
Date: Tue, 21 Dec 2004 23:33:51 +0800
Message-ID: <20041221213624.52ED31A0256@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CgrgS-0007VF-Pw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:36:44 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CgrgS-0002NI-9b
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:36:44 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id CD50BC13B62
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Dec 2004 21:36:30 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- Change timings to as close as possible to VESA specs and
  use msecs_to_jiffies() instead of hard-coded number
- Attempt to read all i2c busses regardless of chipset type

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbdev.c      |    8 +++++---
 rivafb-i2c.c |   44 +++++++++++++-------------------------------
 2 files changed, 18 insertions(+), 34 deletions(-)

diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2004-12-18 20:36:25 +08:00
+++ b/drivers/video/riva/fbdev.c	2004-11-23 21:21:29 +08:00
@@ -1769,17 +1769,19 @@
 static int __devinit riva_get_EDID_i2c(struct fb_info *info)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
+	struct fb_var_screeninfo var;
 	int i;
 
 	NVTRACE_ENTER();
 	riva_create_i2c_busses(par);
-	for (i = par->bus; i >= 1; i--) {
-		riva_probe_i2c_connector(par, i, &par->EDID);
-		if (par->EDID) {
+	for (i = 0; i < par->bus; i++) {
+		riva_probe_i2c_connector(par, i+1, &par->EDID);
+		if (par->EDID && !fb_parse_edid(par->EDID, &var)) {
 			printk(PFX "Found EDID Block from BUS %i\n", i);
 			break;
 		}
 	}
+
 	NVTRACE_LEAVE();
 	return (par->EDID) ? 1 : 0;
 }
diff -Nru a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
--- a/drivers/video/riva/rivafb-i2c.c	2004-10-19 20:24:18 +08:00
+++ b/drivers/video/riva/rivafb-i2c.c	2004-11-23 21:21:30 +08:00
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/fb.h>
+#include <linux/jiffies.h>
 
 #include <asm/io.h>
 
@@ -106,8 +107,7 @@
 	chan->algo.getsda		= riva_gpio_getsda;
 	chan->algo.getscl		= riva_gpio_getscl;
 	chan->algo.udelay		= 40;
-	chan->algo.mdelay               = 5;
-	chan->algo.timeout		= 20;
+	chan->algo.timeout		= msecs_to_jiffies(2);
 	chan->algo.data 		= chan;
 
 	i2c_set_adapdata(&chan->adapter, chan);
@@ -127,39 +127,18 @@
 
 void riva_create_i2c_busses(struct riva_par *par)
 {
+	par->bus = 3;
+
 	par->chan[0].par	= par;
 	par->chan[1].par	= par;
 	par->chan[2].par        = par;
 
-	par->bus = 0;
-
-	switch ((par->pdev->device >> 4) & 0xff) {
-	case 0x17:
-	case 0x18:
-	case 0x25:
-	case 0x28:
-	case 0x30:
-	case 0x31:
-	case 0x32:
-	case 0x33:
-	case 0x34:
-		par->chan[2].ddc_base   = 0x50;
-		par->bus++;
-		riva_setup_i2c_bus(&par->chan[2], "BUS3");
-	case 0x04:
-	case 0x05:
-	case 0x10:
-	case 0x11:
-	case 0x15:
-	case 0x20:
-		par->chan[1].ddc_base	= 0x36;
-		par->bus++;
-		riva_setup_i2c_bus(&par->chan[1], "BUS2");
-	case 0x03:
-		par->chan[0].ddc_base	= 0x3e;
-		par->bus++;
-		riva_setup_i2c_bus(&par->chan[0], "BUS1");
-	}
+	par->chan[0].ddc_base = 0x3e;
+	par->chan[1].ddc_base = 0x36;
+	par->chan[2].ddc_base = 0x50;
+	riva_setup_i2c_bus(&par->chan[0], "BUS1");
+	riva_setup_i2c_bus(&par->chan[1], "BUS2");
+	riva_setup_i2c_bus(&par->chan[2], "BUS3");
 }
 
 void riva_delete_i2c_busses(struct riva_par *par)
@@ -172,6 +151,9 @@
 		i2c_bit_del_bus(&par->chan[1].adapter);
 	par->chan[1].par = NULL;
 
+	if (par->chan[2].par)
+		i2c_bit_del_bus(&par->chan[2].adapter);
+	par->chan[2].par = NULL;
 }
 
 static u8 *riva_do_probe_i2c_edid(struct riva_i2c_chan *chan)




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
