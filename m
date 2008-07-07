From: stefan@datenfreihafen.org
Subject: [Patch 01/10] pxafb: More LCCR3 depth defines
Date: Mon, 07 Jul 2008 20:40:01 +0200
Message-ID: <20080707184125.173098306@datenfreihafen.org>
References: <20080707184000.411913919@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline; filename=pxafb-add-18+bpp-lccr3.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net

Add missing depth definitions to LCCR3.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

PATCH FOLLOWS
KernelVersion: 2.6-arm-git pxa branch

Index: linux-2.6-arm/include/asm-arm/arch-pxa/regs-lcd.h
===================================================================
--- linux-2.6-arm.orig/include/asm-arm/arch-pxa/regs-lcd.h
+++ linux-2.6-arm/include/asm-arm/arch-pxa/regs-lcd.h
@@ -24,6 +24,12 @@
 #define LCCR3_4BPP	(2 << 24)
 #define LCCR3_8BPP	(3 << 24)
 #define LCCR3_16BPP	(4 << 24)
+#define LCCR3_18BPP	(5 << 24)
+#define LCCR3_18BPP_P	(6 << 24)
+#define LCCR3_19BPP	(7 << 24)
+#define LCCR3_19BPP_P	(1 << 29)
+#define LCCR3_24BPP	((1 << 29) | (1 << 24))
+#define LCCR3_25BPP	((1 << 29) | (2 << 24))
 
 #define LCCR3_PDFOR_0	(0 << 30)
 #define LCCR3_PDFOR_1	(1 << 30)

-- 

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
