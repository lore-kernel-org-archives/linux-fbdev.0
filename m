From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] imsttfb 2.5.x
Date: 15 Apr 2003 22:05:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1050437129.2266.6.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0304152030500.8236-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-6-42.abo.wanadoo.fr ([80.11.137.42] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 195WhZ-0007yv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Apr 2003 13:06:45 -0700
In-Reply-To: <Pine.LNX.4.44.0304152030500.8236-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Boris Bezlaj <boris@gajba.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Does readl handle byte swapping on the PPC. The registers expect the data 
> feed to them to be little endian. Actually this driver will only work on 
> the PPC and ix86 platform. Other big endian platforms are out of luck. 

Yes, readl/writel will do the right thing. Use of in_le32 here is
probably for pre-historical reasons ;)

All PCI capabale big endian platforms shall have proper byteswapping
readl/writel.

> P.S
>    This whole issue really sucks. I really wish there was a clean standard 
> api to this. 

There is one, and it's readl/writel ;)

The only real problem is that currently, we lack equivalent of the "s"
versions of in/out macros for mmio. This is a bit annoying for the few
rare case where they would be useful as those shouldn't byteswap, but
re-implementing with __raw_read/writel (which doesn't byteswap neither)
is nasty because it exposes the barrier problem to the driver.

It would be convenient to define {read,write}s{b,w,l} so the IO
accessors and MMIO accessors apre perfectly symetric, but that's an
old debate...
 
Ben.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
