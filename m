From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] imsttfb 2.5.x
Date: 16 Apr 2003 10:26:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1050481571.2265.20.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0304152030500.8236-100000@phoenix.infradead.org>
	 <1050437129.2266.6.camel@zion.wanadoo.fr>  <20030415224313.GA358@gajba.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 195iFX-0001P8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Apr 2003 01:26:36 -0700
In-Reply-To: <20030415224313.GA358@gajba.net>
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
To: Boris Bezlaj <boris@gajba.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-04-16 at 00:43, Boris Bezlaj wrote:
> On Tue, Apr 15, 2003 at 10:05:29PM +0200, Benjamin Herrenschmidt wrote:
> > 
> > > Does readl handle byte swapping on the PPC. The registers expect the data 
> > > feed to them to be little endian. Actually this driver will only work on 
> > > the PPC and ix86 platform. Other big endian platforms are out of luck. 
> 
> It works on ix86? I thought there were problems with ramdac init..must
> try that someday 8)

Possibly, I never tested

> Or would it be better to scrap the read/write_reg_le32 alltogether?

Go on ;)

Ben.

> P.S.
> 	Please check http://knjiznica-jesenice.org/~boris/boot/101_0145.JPG
> What would i need to initialize in ramdac to get rid of "checkerboard" effect? Any ideas?
> 
> 
> 
> --- linux-2.5.50/drivers/video/ORIG_imsttfb.c   2003-04-15 23:06:29.000000000 +0200
> +++ linux-2.5.50/drivers/video/imsttfb.c        2003-04-15 23:07:41.000000000 +0200
> @@ -408,20 +408,12 @@
>   */
>  static inline u32 read_reg_le32(volatile u32 *base, int regindex)
>  {
> -#ifdef __powerpc__
> -       return in_le32((volatile u32 *) (base + regindex));
> -#else
>         return readl(base + regindex);
> -#endif
>  }
> 
>  static inline void write_reg_le32(volatile u32 *base, int regindex, u32 val)
>  {
> -#ifdef __powerpc__
> -       out_le32((volatile u32 *) (base + regindex), val);
> -#else
>         writel(val, base + regindex);
> -#endif
>  }
> 
>  static __u32
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
