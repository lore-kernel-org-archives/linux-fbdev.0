From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Fri, 12 Nov 2004 13:51:26 +0100
Message-ID: <20041112125125.GA3613@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org> <200411090608.02759.adaplas@hotpop.com> <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CSauy-0007gV-44
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Nov 2004 04:52:44 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CSauw-00015G-97
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Nov 2004 04:52:43 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
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
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Mon, Nov 08, 2004 at 02:25:04PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 9 Nov 2004, Antonino A. Daplas wrote:
> > 
> > In big endian machines, the read*/write* accessors do a byteswap for an
> > inherently little endian PCI bus.  However, rivafb puts the hardwire in big
> > endian register access, thus the byteswap is not needed. So for 16- and
> > 32-bit access, instead of read*/write*, use __raw_read*/__raw_write* for all
> > archs.
> 
> Ok, applied with some further simplifications (use "void __iomem *" and 
> suddenly those /2 and /4 just go away - also use __raw_xxxx for the 
> single-byte versions to be consistent).
Doesn't work for me. This one works:

diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
--- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
+++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 13:47:29.400807920 +0100
@@ -75,12 +75,12 @@
  */
 #include <asm/io.h>
 
-#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
-#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
-#define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
-#define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
-#define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
-#define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
+#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
+#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
+#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
+#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
+#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
+#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))
 
 #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
 #define VGA_RD08(p,i)   NV_RD08(p,i)

Interesting enough this one doesn't (only differenc in NV_{WR,RW}08:

diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
--- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
+++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 13:47:29.400807920 +0100
@@ -75,12 +75,12 @@
  */
 #include <asm/io.h>
 
-#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
-#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
-#define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
-#define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
-#define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
-#define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
+#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
+#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
+#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
+#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
+#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
+#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))
 
 #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
 #define VGA_RD08(p,i)   NV_RD08(p,i)

Cheers,
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
