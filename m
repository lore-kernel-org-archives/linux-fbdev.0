From: Boris Bezlaj <boris@gajba.net>
Subject: Re: [PATCH] imsttfb 2.5.x
Date: Wed, 16 Apr 2003 00:43:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030415224313.GA358@gajba.net>
References: <Pine.LNX.4.44.0304152030500.8236-100000@phoenix.infradead.org> <1050437129.2266.6.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.g-kabel.si ([193.189.173.117])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 195Z9J-0002GH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Apr 2003 15:43:34 -0700
Content-Disposition: inline
In-Reply-To: <1050437129.2266.6.camel@zion.wanadoo.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Apr 15, 2003 at 10:05:29PM +0200, Benjamin Herrenschmidt wrote:
> 
> > Does readl handle byte swapping on the PPC. The registers expect the data 
> > feed to them to be little endian. Actually this driver will only work on 
> > the PPC and ix86 platform. Other big endian platforms are out of luck. 

It works on ix86? I thought there were problems with ramdac init..must
try that someday 8)

> Yes, readl/writel will do the right thing. Use of in_le32 here is
> probably for pre-historical reasons ;)
> 
> All PCI capabale big endian platforms shall have proper byteswapping
> readl/writel.
> 
> > P.S
> >    This whole issue really sucks. I really wish there was a clean standard 
> > api to this. 
> 
> There is one, and it's readl/writel ;)
> 
> The only real problem is that currently, we lack equivalent of the "s"
> versions of in/out macros for mmio. This is a bit annoying for the few
> rare case where they would be useful as those shouldn't byteswap, but
> re-implementing with __raw_read/writel (which doesn't byteswap neither)
> is nasty because it exposes the barrier problem to the driver.
> 
> It would be convenient to define {read,write}s{b,w,l} so the IO
> accessors and MMIO accessors apre perfectly symetric, but that's an
> old debate...

I can't really follow you here..not enough knowledge :( Anyway, here's
the mostly tested patch..works for me.

Or would it be better to scrap the read/write_reg_le32 alltogether?

P.S.
	Please check http://knjiznica-jesenice.org/~boris/boot/101_0145.JPG
What would i need to initialize in ramdac to get rid of "checkerboard" effect? Any ideas?



--- linux-2.5.50/drivers/video/ORIG_imsttfb.c   2003-04-15 23:06:29.000000000 +0200
+++ linux-2.5.50/drivers/video/imsttfb.c        2003-04-15 23:07:41.000000000 +0200
@@ -408,20 +408,12 @@
  */
 static inline u32 read_reg_le32(volatile u32 *base, int regindex)
 {
-#ifdef __powerpc__
-       return in_le32((volatile u32 *) (base + regindex));
-#else
        return readl(base + regindex);
-#endif
 }

 static inline void write_reg_le32(volatile u32 *base, int regindex, u32 val)
 {
-#ifdef __powerpc__
-       out_le32((volatile u32 *) (base + regindex), val);
-#else
        writel(val, base + regindex);
-#endif
 }

 static __u32

-- 

  Boris


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
