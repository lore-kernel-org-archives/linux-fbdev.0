From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sat, 13 Nov 2004 12:39:32 +1100
Message-ID: <1100309972.20511.103.camel@gaston>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
	 <200411090402.22696.adaplas@hotpop.com>
	 <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
	 <200411090608.02759.adaplas@hotpop.com>
	 <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
	 <20041112125125.GA3613@bogon.ms20.nix>
	 <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org>
	 <20041112191852.GA4536@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CSmtZ-0007s0-9e
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Nov 2004 17:40:05 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CSmtY-0002UW-Gc
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Nov 2004 17:40:05 -0800
In-Reply-To: <20041112191852.GA4536@bogon.ms20.nix>
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
To: Guido Guenther <agx@sigxcpu.org>
Cc: Linus Torvalds <torvalds@osdl.org>, adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Fri, 2004-11-12 at 20:18 +0100, Guido Guenther wrote:

> O.k., it was the __raw_{write,read}b which broke things, not the
> "alignment". This one works:
> 
> diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
> --- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
> +++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 17:39:22.000000000 +0100
> @@ -75,8 +75,8 @@
>   */
>  #include <asm/io.h>
>  
> -#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
> -#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
> +#define NV_WR08(p,i,d)  (writeb((d), (void __iomem *)(p) + (i)))
> +#define NV_RD08(p,i)    (readb((void __iomem *)(p) + (i)))

Interesting. The only difference here should be barriers. I hate the
lack of barriers in that driver ... I'm not sure the driver may not have
other bugs related to the lack of them in the 16 and 32 bits accessors.
It does use non-barrier version on purpose in some accel ops though,
when filling the fifo with pixels, but that's pretty much the only case
where it makes sense.

> There aren't any, I actually attached the wrong patch. The non-working
> version has __raw_{read,write}b8 instead of {read,write}b8. In 2.6.9
> riva_hw.h used {in,out}_8 for NV_{RD,WR}08 so using the "non-raw"
> writeb/readb now looks correct since these map to {in,out}_8 now.

{in,out}_8 are ppc-specific things that are identical to readb/writeb
indeed, with barriers.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
