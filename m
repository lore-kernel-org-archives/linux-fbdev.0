Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77F1BC061;
	Thu, 10 Oct 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553324; cv=none; b=EMadXTwgb6FvIUG9M3Hy2G3wSfkXxv6JIp9wcIED7P/NZOOQ3FrHSJFKqSKgsggLOehUu/nEQw0M5XmWKn211r7m19lFM50XkV/DhALrZwU+txL5mUrNrb1ejugVWtoUyqLFmvTcBIueVycnM8yCB17j3SG1rbSLIYyMyR7IP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553324; c=relaxed/simple;
	bh=GIEhwdto29dTIdh5H2EYdZNpFROtC3k9we0ptMpXhdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNVprvdOfBahhq50qunOvCDF92oJeWNzpbEowRc2KDLV0D+3R90t4fY7NeExG6z4tvBcUNpULTdRy455nsskURpmEu/tFejS7jfNLjLIeffuQs7Qu3szHGjkh0eh3CAgkiu0O5GiW98ivL/6Et0lyQdJ0CUBUfqo5fuv4NAOMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zX9p2aZ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zX9p2aZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B372C4CEC5;
	Thu, 10 Oct 2024 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728553323;
	bh=GIEhwdto29dTIdh5H2EYdZNpFROtC3k9we0ptMpXhdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zX9p2aZ6jrztUDxeBO52da8z69ZkOWyH9pv6vxWg6T7tWCsGzR0z72bv9P0pmiQIw
	 wQYWZUvXzov9vBTtqAQcR3bdMZoum4WLSwGjC5STMy7KZsiCr6oH31B3SkXL+x3HOS
	 AMpytUXLPJUQ+HvEJoX3uYanfLA+F572B+sKu0Oo=
Date: Thu, 10 Oct 2024 11:41:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Cc: Fabricio Gasperin <fgasperin@lkcamp.dev>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: sm750: Fix missing config in Kconfig
Message-ID: <2024101036-footboard-stinger-9c03@gregkh>
References: <20240921180612.57657-1-fgasperin@lkcamp.dev>
 <20240921180612.57657-2-fgasperin@lkcamp.dev>
 <2024100925-lend-aging-2ff3@gregkh>
 <b8c3c51e-375f-4139-8336-76b6df56e8ea@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8c3c51e-375f-4139-8336-76b6df56e8ea@lkcamp.dev>

On Wed, Oct 09, 2024 at 10:44:38AM -0300, Vinicius Peixoto wrote:
> Hi Greg,
> 
> On 10/9/24 06:56, Greg Kroah-Hartman wrote:
> > On Sat, Sep 21, 2024 at 03:06:09PM -0300, Fabricio Gasperin wrote:
> > > Fixes the following compilation error:
> > > 
> > > ERROR: modpost: "fb_io_read" [drivers/staging/sm750fb/sm750fb.ko] undefined!
> > > ERROR: modpost: "fb_io_write" [drivers/staging/sm750fb/sm750fb.ko] undefined!
> > > ERROR: modpost: "fb_io_mmap" [drivers/staging/sm750fb/sm750fb.ko] undefined!
> > > 
> > > Signed-off-by: Fabricio Gasperin <fgasperin@lkcamp.dev>
> > > ---
> > >   drivers/staging/sm750fb/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/staging/sm750fb/Kconfig b/drivers/staging/sm750fb/Kconfig
> > > index 08bcccdd0f1c..eca1aa43d725 100644
> > > --- a/drivers/staging/sm750fb/Kconfig
> > > +++ b/drivers/staging/sm750fb/Kconfig
> > > @@ -3,6 +3,7 @@ config FB_SM750
> > >   	tristate "Silicon Motion SM750 framebuffer support"
> > >   	depends on FB && PCI && HAS_IOPORT
> > >   	select FB_MODE_HELPERS
> > > +	select FB_IOMEM_FOPS
> > >   	select FB_CFB_FILLRECT
> > >   	select FB_CFB_COPYAREA
> > >   	select FB_CFB_IMAGEBLIT
> > > -- 
> > > 2.46.1
> > > 
> > > 
> > 
> > What is causing this error? What commit created the problem, and why
> > has no one reported it yet?
> 
> This happens because drivers/staging/sm750fb/sm750.c, defines an fb_ops
> structure:
> 
> static const struct fb_ops lynxfb_ops = {
> 	.owner = THIS_MODULE,
> 	FB_DEFAULT_IOMEM_OPS,
> 	...
> };
> 
> FB_DEFAULT_IOMEM_OPS expands to the fb_io_* helpers declared in
> include/linux/fb.h and defined in drivers/video/fbdev/core/fb_io_fops.c;
> however, the latter is gated by FB_IOMEM_FOPS, so when compiling a kernel
> with CONFIG_STAGING=y + CONFIG_FB=m + CONFIG_FB_SM750=m, you get the
> following error:
> 
> ERROR: modpost: "fb_io_read" [drivers/staging/sm750fb/sm750fb.ko] undefined!
> ERROR: modpost: "fb_io_write" [drivers/staging/sm750fb/sm750fb.ko]
> undefined!
> ERROR: modpost: "fb_io_mmap" [drivers/staging/sm750fb/sm750fb.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> 
> So in order to solve it we select FB_IOMEM_FOPS, much like the other FB_*
> drivers do in drivers/video/fbdev/Kconfig.
> 
> Not entirely sure why this wasn't caught before, but the commit that broke
> the build for sm750fb is 6b180f66c0dd ("fbdev: Provide I/O-memory helpers as
> module"), which made the fb_io_* helpers be built as a separate module
> instead of being bundled in fb.o (which is what sm750fb was relying on). I
> think Fabricio can add a "Fixes:" tag in v2.

Ok, thanks for the explaination.  All of this should go into the
changelog text, and yes, a Fixes: tag is also required.

thanks,

greg k-h
