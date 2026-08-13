Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4353D9552;
	Thu, 13 Aug 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644862; cv=none; b=LRJLAgeZBXozNjp2YU/HeHurjQvvahm4qiOdEm3qnwesAbMvebBL9WjqznJV5/INdnyxcsyhQCXi3X3rocBGSB2NffThZHPRxkXet5moijn2hhCKYegx4TaOf2S1mCgk66k7MrFLwJ/FagdKiPcLDExSbn4ww181VgvnQetH2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644862; c=relaxed/simple;
	bh=W9OpoNU/nwpBDGRmavTwz9kzt3bCa99i+KErOB8aKGo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MYkeouvoUtqFy0RNn1eMwhBU2hS1ogCpJgBpTJYDKEn8wSo0WP4YO39uEtZ0iyaM5hLHSU5I/motZo7v5FfDvrPDLy9TtG5rrTBlOKMNrV4wkC7car7/5ugL17kexVWlQCebpqrhVONeGZ3AncQ0HYmiWxdQkkm9m7TONQ/C+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1FD6A92009D; Thu, 13 Aug 2026 20:14:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1AE0892009C;
	Thu, 13 Aug 2026 19:14:17 +0100 (BST)
Date: Thu, 13 Aug 2026 19:14:17 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
    linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
    linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
In-Reply-To: <7282ae0f-3bf5-4eb8-9585-04635de0084a@infradead.org>
Message-ID: <alpine.DEB.2.21.2608131908450.48788@angie.orcam.me.uk>
References: <20260809234810.982500-1-rdunlap@infradead.org> <8ce99afa-1162-4910-92a4-6cb2973ea977@oss.qualcomm.com> <7282ae0f-3bf5-4eb8-9585-04635de0084a@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 9 Aug 2026, Randy Dunlap wrote:

> >> --- linux-next-20260807.orig/include/video/maxinefb.h
> >> +++ linux-next-20260807/include/video/maxinefb.h
> >> @@ -13,13 +13,13 @@
> >>   /*
> >>    * IMS332 video controller register base address
> >>    */
> >> -#define MAXINEFB_IMS332_ADDRESS        KSEG1ADDR(0x1c140000)
> >> +#define MAXINEFB_IMS332_ADDRESS        CKSEG1ADDR(0x1c140000)
> >>     /*
> >>    * Begin of DECstation 5000/xx onboard framebuffer memory, default resolution
> >>    * is 1024x768x8
> >>    */
> >> -#define DS5000_xx_ONBOARD_FBMEM_START    KSEG1ADDR(0x0a000000)
> >> +#define DS5000_xx_ONBOARD_FBMEM_START    CKSEG1ADDR(0x0a000000)
> > 
> > The change looks correct, but clearly this has never been tested
> > on a 64-bit DECstation, so I'm not sure having this code being
> > now built is an improvement.

 I don't expect any issues and FWIW the Maxine does support a 64-bit CPU 
module.

> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index ac9ac4287c6a..ff17afe6b8b3 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -1436,7 +1436,7 @@ config FB_PMAGB_B
> > 
> >  config FB_MAXINE
> >         bool "Maxine (Personal DECstation) onboard framebuffer support"
> > -       depends on (FB = y) && MACH_DECSTATION
> > +       depends on (FB = y) && MACH_DECSTATION && 32BIT
> >         select FB_IOMEM_HELPERS
> >         help
> >           Support for the onboard framebuffer (1024x768x8) in the Personal
> > ---
> > 
> > ?
> 
> I guess I'm OK with that. I'm even OK with removing the driver completely.

 No need to limit the driver to 32BIT and as I suggest in the other reply 
fixing 64BIT will best be a separate change.

> Maciej did say in https://lore.kernel.org/all/alpine.DEB.2.21.2308152255080.8596@angie.orcam.me.uk/
> that: "the proper way would be by using `ioremap' really.  I'll make a patch."
> [That was 15.Aug.2023.]

 Even more properly this will best be converted to a platform device and 
then resource handling will DTRT.  I do hope to get a specimen eventually, 
so I think there's no need to rush making changes on paper.

  Maciej
