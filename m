From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Tue, 9 Nov 2004 04:02:19 +0800
Message-ID: <200411090402.22696.adaplas@hotpop.com>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411081706.55261.adaplas@hotpop.com> <Pine.LNX.4.58.0411080719460.24286@ppc970.osdl.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261211AbUKHUDM@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411080719460.24286@ppc970.osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Monday 08 November 2004 23:21, Linus Torvalds wrote:
> On Mon, 8 Nov 2004, Antonino A. Daplas wrote:
> > How about this patch?  This is almost the original macro in riva_hw.h,
> > with the __force annotation.
>
> Why not just use __raw_readl/__raw_writel?
>

Ok.

Tony

In big endian machines, the read*/write* accessors do a byteswap for an
inherently little endian PCI bus.  However, rivafb puts the hardwire in big
endian register access, thus the byteswap is not needed. So, instead of
read*/write*, use __raw_read*/__raw_write*.
 
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
--- a/drivers/video/riva/riva_hw.h	2004-11-09 03:45:55 +08:00
+++ b/drivers/video/riva/riva_hw.h	2004-11-09 03:50:32 +08:00
@@ -77,14 +77,18 @@
 #include <asm/io.h>
 #define NV_WR08(p,i,d)	out_8(p+i, d)
 #define NV_RD08(p,i)	in_8(p+i)
+#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
+#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
+#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
+#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))
 #else
 #define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
 #define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
-#endif
 #define NV_WR16(p,i,d)  (writew((d), (u16 __iomem *)(p) + (i)/2))
 #define NV_RD16(p,i)    (readw((u16 __iomem *)(p) + (i)/2))
 #define NV_WR32(p,i,d)  (writel((d), (u32 __iomem *)(p) + (i)/4))
 #define NV_RD32(p,i)    (readl((u32 __iomem *)(p) + (i)/4))
+#endif
 #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
 #define VGA_RD08(p,i)   NV_RD08(p,i)
 
