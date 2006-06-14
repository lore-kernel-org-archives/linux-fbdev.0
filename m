From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 1/5 2.6.17-rc6-mm2] add vsync interrupt
	support to intelfb driver
Date: Wed, 14 Jun 2006 09:10:22 -0400
Message-ID: <A04A8727-4958-4569-9F10-255BD11367FD@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqV64-0006xC-Dj for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:07:48 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FqV64-0002dI-82 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:07:48 -0700
Received: from mail8.sea5.speakeasy.net ([69.17.117.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqV62-0004mw-Gw
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:07:48 -0700
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
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

From: Eric Hustvedt <ehustvedt@cecropia.com>

[01/05] intelfb: Add 16-bit register access macros

This patch adds macros to read and write two-byte MMIO registers. The
interrupt-related registers are all word-sized, rather than long-sized.

Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
---

drivers/video/intelfb/intelfbhw.h |    3 +++
1 file changed, 3 insertions(+)

diff -X linux-2.6.17-rc4-cecropia/Documentation/dontdiff -Naurp  
linux-2.6.17-rc4-cecropia/drivers/video/intelfb/intelfbhw.h  
linux-2.6.17-rc4-stable/drivers/video/intelfb/intelfbhw.h
--- linux-2.6.17-rc4-cecropia/drivers/video/intelfb/intelfbhw.h	 
2006-05-26 10:06:30.000000000 -0600
+++ linux-2.6.17-rc4-stable/drivers/video/intelfb/intelfbhw.h	 
2006-06-07 11:14:18.000000000 -0600
@@ -468,9 +474,12 @@
/* I/O macros */
#define INREG8(addr)	      readb((u8 __iomem *)(dinfo->mmio_base +  
(addr)))
+#define INREG16(addr)	      readw((u16 __iomem *)(dinfo->mmio_base +  
(addr)))
#define INREG(addr)	      readl((u32 __iomem *)(dinfo->mmio_base +  
(addr)))
#define OUTREG8(addr, val)    writeb((val),(u8 __iomem *)(dinfo- 
 >mmio_base + \
							   (addr)))
+#define OUTREG16(addr, val)    writew((val),(u16 __iomem *)(dinfo- 
 >mmio_base + \
+							   (addr)))
#define OUTREG(addr, val)     writel((val),(u32 __iomem *)(dinfo- 
 >mmio_base + \
                                       (addr)))
