From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.17-rc6-mm2 1/5] intelfb: RESEND -
	add vsync interrupt support
Date: Tue, 20 Jun 2006 14:31:38 -0400 (EDT)
Message-ID: <20060620183138.2763890CE10@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FslG7-0002iW-2L for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:47:31 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FskxR-0004nA-RA for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:28:13 -0700
Received: from mail3.sea5.speakeasy.net ([69.17.117.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FskxR-0005Au-Lj
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:28:13 -0700
Received: from lex098.cecropia.com (HELO xenon)
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail3.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	20 Jun 2006 18:28:12 -0000
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

From: Eric Hustvedt <ehustvedt@cecropia.com>

[01/05] intelfb: Add 16-bit register access macros

This patch adds macros to read and write two-byte MMIO registers. The interrupt-related registers are all word-sized, rather than long-sized.

Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
---

 drivers/video/intelfb/intelfbhw.h |    3 +++
 1 file changed, 3 insertions(+)

diff -X linux-2.6.17-rc4-cecropia/Documentation/dontdiff -Naurp linux-2.6.17-rc4-cecropia/drivers/video/intelfb/intelfbhw.h linux-2.6.17-rc4-stable/drivers/video/intelfb/intelfbhw.h
--- linux-2.6.17-rc4-cecropia/drivers/video/intelfb/intelfbhw.h	2006-05-26 10:06:30.000000000 -0600
+++ linux-2.6.17-rc4-stable/drivers/video/intelfb/intelfbhw.h	2006-06-07 11:14:18.000000000 -0600
@@ -468,9 +474,12 @@
 
 /* I/O macros */
 #define INREG8(addr)	      readb((u8 __iomem *)(dinfo->mmio_base + (addr)))
+#define INREG16(addr)	      readw((u16 __iomem *)(dinfo->mmio_base + (addr)))
 #define INREG(addr)	      readl((u32 __iomem *)(dinfo->mmio_base + (addr)))
 #define OUTREG8(addr, val)    writeb((val),(u8 __iomem *)(dinfo->mmio_base + \
 							   (addr)))
+#define OUTREG16(addr, val)    writew((val),(u16 __iomem *)(dinfo->mmio_base + \
+							   (addr)))
 #define OUTREG(addr, val)     writel((val),(u32 __iomem *)(dinfo->mmio_base + \
                                      (addr)))
