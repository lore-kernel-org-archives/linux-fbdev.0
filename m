From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] trident fb section fixes
Date: Thu, 8 Jun 2006 20:38:54 -0700
Message-ID: <20060608203854.2379a987.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FoY0u-0004xM-8U for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Jun 2006 20:50:26 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FoY0t-0003Vx-Vl for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Jun 2006 20:50:23 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FoY0s-0004CP-Vx
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Jun 2006 20:50:24 -0700
Received: from midway.site ([71.245.102.105]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 8 Jun 2006 20:50:20 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm <akpm@osdl.org>, adaplas@pol.net, jani@iv.ro

From: Randy Dunlap <rdunlap@xenotime.net>

Priority: not critical.
Change 3 functions from __init to __devinit.
Could be an init/probe problem in theory, but not observed, so not
high priority IMO.

Fix section mismatch warnings:
WARNING: drivers/video/tridentfb.o - Section mismatch: reference to .init.text: from .text between 'trident_pci_probe' (at offset 0x1aad) and 'trident_pci_remove'
WARNING: drivers/video/tridentfb.o - Section mismatch: reference to .init.text: from .text between 'trident_pci_probe' (at offset 0x1b22) and 'trident_pci_remove'
WARNING: drivers/video/tridentfb.o - Section mismatch: reference to .init.text: from .text between 'trident_pci_probe' (at offset 0x1b31) and 'trident_pci_remove'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/video/tridentfb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2617-rc6.orig/drivers/video/tridentfb.c
+++ linux-2617-rc6/drivers/video/tridentfb.c
@@ -551,7 +551,7 @@ static inline void enable_mmio(void)
 #define crtc_unlock()	write3X4(CRTVSyncEnd, read3X4(CRTVSyncEnd) & 0x7F)
 
 /*  Return flat panel's maximum x resolution */
-static int __init get_nativex(void)
+static int __devinit get_nativex(void)
 {
 	int x,y,tmp;
 
@@ -658,7 +658,7 @@ static void set_number_of_lines(int line
  * If we see that FP is active we assume we have one.
  * Otherwise we have a CRT display.User can override.
  */
-static unsigned int __init get_displaytype(void)
+static unsigned int __devinit get_displaytype(void)
 {
 	if (fp)
 		return DISPLAY_FP;
@@ -668,7 +668,7 @@ static unsigned int __init get_displayty
 }
 
 /* Try detecting the video memory size */
-static unsigned int __init get_memsize(void)
+static unsigned int __devinit get_memsize(void)
 {
 	unsigned char tmp, tmp2;
 	unsigned int k;


---
