From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm2
Date: Thu, 19 Aug 2004 23:08:50 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040819230850.09d7d274.akpm@osdl.org>
References: <20040819014204.2d412e9b.akpm@osdl.org>
	<20040820005019.GB6374@logos.cnet>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By2bn-0005EX-9r
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 19 Aug 2004 23:10:39 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1By2bl-0008Q9-PD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 19 Aug 2004 23:10:39 -0700
In-Reply-To: <20040820005019.GB6374@logos.cnet>
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
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


(switched mailing lists)

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> On Thu, Aug 19, 2004 at 01:42:04AM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm2/
> > 
> > - Added Tony Luck's ia64 devel tree to the -mm "external trees" lineup.
> > 
> > - The monster memory leak which some people were seeing with audio CD
> 
> Hi Andrew,
> 
> Just annoying your arse, I get this:
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0xa1bde): In function `radeon_match_mode':
> : undefined reference to `vesa_modes'
> drivers/built-in.o(.text+0xa1cbd): In function `radeon_match_mode':
> : undefined reference to `vesa_modes'
> make: ** [.tmp_vmlinux1] Erro 1
> 
> Known already?

nope.  That symbol is exported to modules.

Please send .config.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
