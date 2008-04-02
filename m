From: York Sun <yorksun@freescale.com>
Subject: Re: [PATCH 2/2 v5] Add DIU platform code for
	MPC8610HPCD
Date: Wed, 02 Apr 2008 08:27:43 -0500
Message-ID: <1207142863.20695.19.camel@laptop>
References: <12069806051060-git-send-email-yorksun@freescale.com>
	<1206980605689-git-send-email-yorksun@freescale.com>
	<12069806051291-git-send-email-yorksun@freescale.com>
	<20080401140029.be918d87.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jh30R-0002yT-HK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Apr 2008 06:27:59 -0700
Received: from de01egw02.freescale.net ([192.88.165.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jh30P-0000VZ-Ha
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Apr 2008 06:27:59 -0700
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m32DRjKt003585 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 2 Apr 2008 06:27:46 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m32DRjtP002586
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 2 Apr 2008 08:27:45 -0500 (CDT)
In-Reply-To: <20080401140029.be918d87.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, galak@kernel.crashing.org, linuxppc-dev@ozlabs.org, scottwood@freescale.com, avorontsov@ru.mvista.com, timur@freescale.com

On Tue, 2008-04-01 at 14:00 -0700, Andrew Morton wrote:
> On Mon, 31 Mar 2008 11:23:25 -0500
> York Sun <yorksun@freescale.com> wrote:
> 
> > Add platform code to support Freescale DIU. The platform code includes
> > framebuffer memory allocation, pixel format, monitor port, etc.
> > 
> > Signed-off-by: York Sun <yorksun@freescale.com>
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> > ---
> > This patch addes platform support for Freescale DIU driver, targeting 2.6.26 kernel.
> > 
> >  arch/powerpc/configs/mpc8610_hpcd_defconfig |  198 +++++++++++++++++++++++----
> >  arch/powerpc/platforms/86xx/mpc8610_hpcd.c  |  190 ++++++++++++++++++++++++--
> >  arch/powerpc/sysdev/fsl_soc.c               |   41 ++++++
> >  arch/powerpc/sysdev/fsl_soc.h               |   23 +++
> >  4 files changed, 413 insertions(+), 39 deletions(-)
> 
> The defconfig change gets almost 100% rejects and probably isn't
> appropriate here and isn't very important.  I dropped that part of the
> patch.
> 

It's OK.

York


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
