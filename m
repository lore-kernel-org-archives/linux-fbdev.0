From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: x86_64 64bit kernel rivafb broke between 2.6.8.1 and linus bk as of today
Date: Thu, 18 Nov 2004 06:23:28 +0800
Message-ID: <200411180623.28248.adaplas@hotpop.com>
References: <200411162244.37709.andrew@walrond.org> <200411170033.38614.andrew@walrond.org> <200411171107.21823.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_g98mBoWRXzjNAaZ"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUYEZ-0001MD-RW
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 14:25:03 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CUYET-0007ah-Ur
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 14:25:03 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 85C8B11ED472
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Nov 2004 22:24:42 +0000 (UTC)
In-Reply-To: <200411171107.21823.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>


--Boundary-00=_g98mBoWRXzjNAaZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 17 November 2004 19:07, Andrew Walrond wrote:
> On Wednesday 17 Nov 2004 00:33, Andrew Walrond wrote:
> > On Wednesday 17 Nov 2004 00:15, Antonino A. Daplas wrote:
> > > There was a bunch of IO access fixes in rivafb.  Can you narrow it down
> > > to a particular function?  Replace the following...
> > >
> > >  .fb_fillrect  = rivafb_fillrect,
>
> Broken.
>
> > >  .fb_copyarea  = rivafb_copyarea,
>
> seems ok
>
> > >  .fb_imageblit  = rivafb_imageblit,
>
> broken.
>

I was suspecting imageblit, I never suspected fillrect.  Anyway, can you try
the 2 patches attached.  The first patch reverts io access to the old method
(direct pointer loading/reading and forced alignment) and the second uses
__raw_{read|write} but forces alignment. You need to reverse the previous
patch before applying the other.

If none of the patches work, it will entail more work.  Revert the following
functions to linux-2.6.10-rc1, in the given order and preferrably one at a
time.

riva_set_pattern()
riva_set_rop_solid()
riva_setup_accel()
rivafb_imageblit()
rivafb_fillrect()

Tony



--Boundary-00=_g98mBoWRXzjNAaZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="rivafb-ioaccess-revert1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rivafb-ioaccess-revert1.diff"

diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
--- a/drivers/video/riva/riva_hw.h	2004-11-17 18:29:40 +08:00
+++ b/drivers/video/riva/riva_hw.h	2004-11-18 05:54:17 +08:00
@@ -73,17 +73,20 @@
 /*
  * HW access macros.
  */
+#if defined(__powerpc__)
 #include <asm/io.h>
-
-#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
-#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
-#define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
-#define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
-#define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
-#define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
-
-#define VGA_WR08(p,i,d) (writeb((d), (void __iomem *)(p) + (i)))
-#define VGA_RD08(p,i)   (readb((void __iomem *)(p) + (i)))
+#define NV_WR08(p,i,d)	out_8(p+i, d)
+#define NV_RD08(p,i)	in_8(p+i)
+#else
+#define NV_WR08(p,i,d)  (((U008 *)(p))[i]=(d))
+#define NV_RD08(p,i)    (((U008 *)(p))[i])
+#endif
+#define NV_WR16(p,i,d)  (((U016 *)(p))[(i)/2]=(d))
+#define NV_RD16(p,i)    (((U016 *)(p))[(i)/2])
+#define NV_WR32(p,i,d)  (((U032 *)(p))[(i)/4]=(d))
+#define NV_RD32(p,i)    (((U032 *)(p))[(i)/4])
+#define VGA_WR08(p,i,d) NV_WR08(p,i,d)
+#define VGA_RD08(p,i)   NV_RD08(p,i)
 
 /*
  * Define different architectures.

--Boundary-00=_g98mBoWRXzjNAaZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="rivafb-ioaccess-revert2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rivafb-ioaccess-revert2.diff"

diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
--- a/drivers/video/riva/riva_hw.h	2004-11-17 18:29:40 +08:00
+++ b/drivers/video/riva/riva_hw.h	2004-11-18 06:06:02 +08:00
@@ -75,12 +75,12 @@
  */
 #include <asm/io.h>
 
-#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
-#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
-#define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
-#define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
-#define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
-#define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
+#define NV_WR08(p,i,d)  (__raw_writeb((d), (u8 __iomem *)(p) + (i)))
+#define NV_RD08(p,i)    (__raw_readb((u8 __iomem *)(p) + (i)))
+#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
+#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
+#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
+#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))
 
 #define VGA_WR08(p,i,d) (writeb((d), (void __iomem *)(p) + (i)))
 #define VGA_RD08(p,i)   (readb((void __iomem *)(p) + (i)))

--Boundary-00=_g98mBoWRXzjNAaZ--




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
