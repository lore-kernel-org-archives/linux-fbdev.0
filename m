From: Helge Deller <deller@gmx.de>
Subject: [PATCH] don't activate unsupported GSC STI cards on HPPA
Date: Mon, 16 Jun 2008 22:50:28 +0200
Message-ID: <200806162250.28773.deller@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-parisc@vger.kernel.org

On HPPA there exists some older GSC graphics cards, which
need special graphic-card-BIOS patching to become supported.
Since we don't have yet implemented the patching, it's better
to detect such cards in advance, inform to the user that there 
are known problems and to not activate the card.

Problematic GSC cards and BIOS versions are:
* Hyperdrive/Hyperbowl (A4071A) graphics card series: 
   * ID = 0x2BCB015A (Version 8.04/8)
   * ID = 0x2BCB015A (Version 8.04/11)
* Thunder 1 VISUALIZE 48 card: 
   * ID = 0x2F23E5FC (Version 8.05/9)
* Thunder 2 VISUALIZE 48 XP card: 
   * ID = 0x2F8D570E (Version 8.05/12)
* Some Hyperion and ThunderHawk GSC cards

Further details are described here:
http://parisc-linux.org/faq/graphics-howto.html


Signed-off-by: Helge Deller <deller@gmx.de>


 sticore.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)


diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index e9ab657..e5eec26 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -24,6 +24,7 @@
 #include <asm/hardware.h>
 #include <asm/parisc-device.h>
 #include <asm/cacheflush.h>
+#include <asm/grfioctl.h>
 
 #include "../sticore.h"
 
@@ -728,6 +729,7 @@ sti_read_rom(int wordmode, struct sti_struct *sti, unsigned long address)
 {
 	struct sti_cooked_rom *cooked;
 	struct sti_rom *raw = NULL;
+	unsigned long revno;
 
 	cooked = kmalloc(sizeof *cooked, GFP_KERNEL);
 	if (!cooked)
@@ -770,9 +772,35 @@ sti_read_rom(int wordmode, struct sti_struct *sti, unsigned long address)
 	sti->graphics_id[1] = raw->graphics_id[1];
 	
 	sti_dump_rom(raw);
-	
+
+	/* check if the ROM routines in this card are compatible */
+	if (wordmode || sti->graphics_id[1] != 0x09A02587)
+		goto ok;
+
+	revno = (raw->revno[0] << 8) | raw->revno[1];
+
+	switch (sti->graphics_id[0]) {
+	case S9000_ID_HCRX:
+		/* HyperA or HyperB ? */
+		if (revno == 0x8408 || revno == 0x840b)
+			goto msg_not_supported;
+		break;
+	case CRT_ID_THUNDER:
+		if (revno == 0x8509)
+			goto msg_not_supported;
+		break;
+	case CRT_ID_THUNDER2:
+		if (revno == 0x850c)
+			goto msg_not_supported;
+	}
+ok:
 	return 1;
 
+msg_not_supported:
+	printk(KERN_ERR "Sorry, this GSC/STI card is not yet supported.\n");
+	printk(KERN_ERR "Please see http://parisc-linux.org/faq/"
+			"graphics-howto.html for more info.\n");
+	/* fall through */
 out_err:
 	kfree(raw);
 	kfree(cooked);
