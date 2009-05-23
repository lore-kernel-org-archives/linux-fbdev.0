From: Harald Welte <HaraldWelte@viatech.com>
Subject: Re: [PATCH 13/15] viafb: initialize 2D
	engine	registers from loop
Date: Sat, 23 May 2009 17:33:16 +0800
Message-ID: <20090523093316.GR4021@prithivi.gnumonks.org>
References: <1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-10-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-11-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-12-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-13-git-send-email-HaraldWelte@viatech.com>
	<20090523082704.d5dc7052.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1M7niF-0007b5-NZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:40:19 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M7niD-0003Ue-Vh
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:40:19 +0000
Content-Disposition: inline
In-Reply-To: <20090523082704.d5dc7052.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sat, May 23, 2009 at 08:27:04AM +0200, Krzysztof Helt wrote:
> On Thu, 21 May 2009 04:28:51 +0800
> Harald Welte <HaraldWelte@viatech.com> wrote:
> 
> > From: Harald Welte <laforge@gnumonks.org>
> > 
> > We don't need to unroll the register initialization routine when
> > initializing the 2D engine registers

[...]

> > -	writel(0x0, viaparinfo->io_virt + VIA_REG_PITCH);
> > -	writel(0x0, viaparinfo->io_virt + VIA_REG_MONOPAT1);
> > +	for (i = 0; i <= 0x40; i+= 4)
> > +		writel(0x0, viaparinfo->io_virt + i);
> >  
> 
> Use your new viafb_2d_writel() here.

Sorry I have to disagree...
specifically here I do not want to use it.  I actually know that all the
registers reside in a contiguous MMIO space, and I want to zero-initialize all
of them from beginning to the end.  There is no need in permutating the
addresses in this case, since I don't care about the individual registers
purpose.

-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
