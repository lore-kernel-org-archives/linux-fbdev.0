Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0513876BB;
	Thu, 13 Aug 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642322; cv=none; b=pfHCic1YH5jnSecxkjuQwrsQltSAf3WBZe0voGi+EGSm2zd3WWETKpdd4yPSNInH4JohgZqV0/v+Njyznn0aG3/THN3+4hgkjeGups2nEHr4eq2zmR6mXmvhjUpDkrdqT8WBWjouvajUuLu9m2LIEDxzwz8FKImWIfZcCw+KzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642322; c=relaxed/simple;
	bh=f1n0BmojRQVNi1iwF7OD2jqYeZdLmWSy3m78MdpnP0A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sy3Ffk4nJ5uIjHFcU/2j0vo854fwPrL3/A7Ux/yt6ybFQWhtIL3D6CNjXP4KnXvFUxPR06l2tvCAl+61lAoiDDGUBBwW8Lwgmyfa8drXPAnFCckaPI+esJb6AjTuvVJrl66MIyB9zZX1+fGjXEY7PppI0/tp8q2Lq+zwF+3uRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1026692009C; Thu, 13 Aug 2026 19:31:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0B8BE92009B;
	Thu, 13 Aug 2026 18:31:51 +0100 (BST)
Date: Thu, 13 Aug 2026 18:31:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
    linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
In-Reply-To: <20260809234810.982500-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2608131801340.48788@angie.orcam.me.uk>
References: <20260809234810.982500-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 9 Aug 2026, Randy Dunlap wrote:

> This is all ancient source code from the beginning of git time.

 I can dig out any further details you may need from the old LMO git tree.  
Eventually it's planned to be put back online, but resources.

> Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.

 Thanks for doing this work.

> Suggested-by: "Maciej W. Rozycki" <macro@orcam.me.uk> # for s/KSEG1ADDR/CKSEG1ADDR/

 Eventually this code should be converted to a platform device, so such 
hacks won't be necessary.  Sadly I declined an offer back in 2009 and I 
have been chasing a specimen for a while now.  And since it's an onboard 
device unlike all the TURBOchannel framebuffers, there's no alternative.

> --- linux-next-20260807.orig/drivers/video/fbdev/maxinefb.c
> +++ linux-next-20260807/drivers/video/fbdev/maxinefb.c
> @@ -71,19 +71,6 @@ void maxinefb_ims332_write_register(int
>  	*((volatile unsigned short *) (wptr)) = val;
>  }
>  
> -unsigned int maxinefb_ims332_read_register(int regno)
> -{
> -	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
> -	unsigned char *rptr;
> -	register unsigned int j, k;
> -
> -	rptr = regs + 0x80000 + (regno << 4);
> -	j = *((volatile unsigned short *) rptr);
> -	k = *((volatile unsigned short *) regs);
> -
> -	return (j & 0xffff) | ((k & 0xff00) << 8);
> -}
> -
>  /* Set the palette */
>  static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
>  			      unsigned blue, unsigned transp, struct fb_info *info)

 It might be worth mentioning in the change description that this is dead 
code (and overall provide a summary as to making functions static, etc.).  
Though I'm not entirely convinced as to the removal since this function 
documents the hardware interface, which must have been the intent to put 
it there.  Perhaps #if 0?

> --- linux-next-20260807.orig/include/video/maxinefb.h
> +++ linux-next-20260807/include/video/maxinefb.h
> @@ -13,13 +13,13 @@
>  /*
>   * IMS332 video controller register base address
>   */
> -#define MAXINEFB_IMS332_ADDRESS		KSEG1ADDR(0x1c140000)
> +#define MAXINEFB_IMS332_ADDRESS		CKSEG1ADDR(0x1c140000)
>  
>  /*
>   * Begin of DECstation 5000/xx onboard framebuffer memory, default resolution
>   * is 1024x768x8
>   */
> -#define DS5000_xx_ONBOARD_FBMEM_START	KSEG1ADDR(0x0a000000)
> +#define DS5000_xx_ONBOARD_FBMEM_START	CKSEG1ADDR(0x0a000000)
>  
>  /*
>   *      The IMS 332 video controller used in the DECstation 5000/xx series

 This would probably best be a separate change, especially as it's not 
needed for 32BIT.

 I'm not sure how the actual maintainers see it (I should probably list 
myself for all the scattered DECstation stuff), but I think this would 
best be a patch series of 3 for each of the individual classes of fixes.  
And since this borders on the obvious I wouldn't be too concerned as to 
the change descriptions; just one sentence plus the relevant error message 
quoted will do.  And your introduction should suffice as the cover letter.

 Let me know if this works for you and if you post such a series, I'll ack 
it right away.

  Maciej
