From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Mon, 8 Nov 2004 17:06:54 +0800
Message-ID: <200411081706.55261.adaplas@hotpop.com>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <1099893447.10262.154.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CR5UW-0001v0-W9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 01:07:12 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CR5UW-0005IO-5J
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 01:07:12 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 45F4B11BEEEA
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  8 Nov 2004 09:06:55 +0000 (UTC)
In-Reply-To: <1099893447.10262.154.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

On Monday 08 November 2004 13:57, Benjamin Herrenschmidt wrote:
> > diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
> > --- a/drivers/video/riva/riva_hw.h	2004-11-07 21:21:47 -08:00
> > +++ b/drivers/video/riva/riva_hw.h	2004-11-07 21:21:47 -08:00
> > @@ -78,13 +78,13 @@
> >  #define NV_WR08(p,i,d)	out_8(p+i, d)
> >  #define NV_RD08(p,i)	in_8(p+i)
> >  #else
> > -#define NV_WR08(p,i,d)  (((U008 *)(p))[i]=(d))
> > -#define NV_RD08(p,i)    (((U008 *)(p))[i])
> > +#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
> > +#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
> >  #endif
> > -#define NV_WR16(p,i,d)  (((U016 *)(p))[(i)/2]=(d))
> > -#define NV_RD16(p,i)    (((U016 *)(p))[(i)/2])
> > -#define NV_WR32(p,i,d)  (((U032 *)(p))[(i)/4]=(d))
> > -#define NV_RD32(p,i)    (((U032 *)(p))[(i)/4])
> > +#define NV_WR16(p,i,d)  (writew((d), (u16 __iomem *)(p) + (i)/2))
> > +#define NV_RD16(p,i)    (readw((u16 __iomem *)(p) + (i)/2))
> > +#define NV_WR32(p,i,d)  (writel((d), (u32 __iomem *)(p) + (i)/4))
> > +#define NV_RD32(p,i)    (readl((u32 __iomem *)(p) + (i)/4))
> >  #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
> >  #define VGA_RD08(p,i)   NV_RD08(p,i)
>
> You probably broke ppc versions here. The driver enables "big endian"
> register access, but readw/writew/l functions do byteswap, which will
> lead to incorrect results.
>
> The fix would be to probably just remove the code that puts the chip
> registers into big endian mode, this isn't necessary nor a very good
> idea actually.
>

How about this patch?  This is almost the original macro in riva_hw.h,
with the __force annotation.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
--- a/drivers/video/riva/riva_hw.h	2004-11-06 12:42:19 +08:00
+++ b/drivers/video/riva/riva_hw.h	2004-11-08 16:59:34 +08:00
@@ -77,14 +77,18 @@
 #include <asm/io.h>
 #define NV_WR08(p,i,d)	out_8(p+i, d)
 #define NV_RD08(p,i)	in_8(p+i)
+#define NV_WR16(p,i,d)  (((volatile u16 __force *)(p))[(i)/2]=(d))
+#define NV_RD16(p,i)    (((volatile u16 __force *)(p))[(i)/2])
+#define NV_WR32(p,i,d)  (((volatile u32 __force *)(p))[(i)/4]=(d))
+#define NV_RD32(p,i)    (((volatile u32 __force *)(p))[(i)/4])
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
 




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
