From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: 2.6.8.1-mm2
Date: Fri, 20 Aug 2004 17:11:26 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408201711.26091.adaplas@hotpop.com>
References: <20040819014204.2d412e9b.akpm@osdl.org> <20040820005019.GB6374@logos.cnet> <20040819230850.09d7d274.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By5Qu-0006zd-GD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 02:11:36 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1By5Qu-0006Y5-2R
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 02:11:36 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id ECEC47B1444
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 20 Aug 2004 08:14:54 +0000 (UTC)
In-Reply-To: <20040819230850.09d7d274.akpm@osdl.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Friday 20 August 2004 14:08, Andrew Morton wrote:
> (switched mailing lists)
>
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > On Thu, Aug 19, 2004 at 01:42:04AM -0700, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2
> > >.6.8.1-mm2/
> > >
> > > - Added Tony Luck's ia64 devel tree to the -mm "external trees" lineup.
> > >
> > > - The monster memory leak which some people were seeing with audio CD
> >
> > Hi Andrew,
> >
> > Just annoying your arse, I get this:
> >
> >   LD      .tmp_vmlinux1
> >
> > drivers/built-in.o(.text+0xa1bde): In function `radeon_match_mode':
> > : undefined reference to `vesa_modes'
> >
> > drivers/built-in.o(.text+0xa1cbd): In function `radeon_match_mode':
> > : undefined reference to `vesa_modes'
> >
> > make: ** [.tmp_vmlinux1] Erro 1
> >
> > Known already?
>
> nope.  That symbol is exported to modules.
>

Oops.  vesa_modes is now dependent on CONFIG_FB_MODE_HELPERS.  
I'll submit a patch over the weekend to fix drivers that require this option.

Tony




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
