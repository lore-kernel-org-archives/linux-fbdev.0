Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265AC19412F
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Aug 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546797; cv=none; b=Q4ords9cx0fsD9oMibKYGN4c23DIaH3XQxtavbDUQ70MyWS9eXW5a0Tj4NvPD6I7DXfySel3HsgcCjPEIlDqgfuQFF7up+WXbH0y6gwRbr0ATO+Nst3XwaWo0AsTc/SWReJ+DGp9pFJ+2TqF9keOF7TD51r9SFcQXkez8Rtt3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546797; c=relaxed/simple;
	bh=x1zUFuclTh42KXUzQhw11T5X/fWiXNo6Xwb2asIewE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsW4MZ5bpuWU9EIprnMoMsWw6VIpl5y/gnAAaSW631xHR0vspd7gxRu+97xQFN/nc+54ute90RWQufd76DcGsO7H767pa51tMa29NZ5606RmZIGFqFjgmyWD1K0rEvIY/3Vj9/W5HArlobpL0nlYixAMSEl91OduoSykGlgcQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Thz/SQSs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Thz/SQSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723546795; x=1755082795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x1zUFuclTh42KXUzQhw11T5X/fWiXNo6Xwb2asIewE8=;
  b=Thz/SQSsslEjNHOYCezEel/8ddNt81ljtPS74J+Qodf+MAQ5Xx0jlqUp
   tyE3rBDbC6mZbz4w8iwq/XcEmNA+BN+eCw0caJmxxMdHa+X1Hlfxy4r6T
   T8gWjgAxk+jfnwa1oLLLQKY9rmy3ub8fqbfmRscuLr5Yu5gAeFMsUf1R8
   KQerP2UDOs/NdwmiQYHd9FsYliEmghsyNP6TB+pMOjgciUIcf81JYta6p
   7P+y5B6bDKal8MvbUnYDa9ec4GELohOOv1QC/JmIJy9ApOlzdabXZRF5t
   LyvjwK/GZfaindhxQH7k9gj9vMye3Gea+vMQ3b2ti1HGUgYJ1iBDxNX0t
   A==;
X-CSE-ConnectionGUID: WR1rd4s2Qk2AzS1sCrJckQ==
X-CSE-MsgGUID: UoJ9hZA5Qyidzq5TZATlhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33084721"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="33084721"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:59:54 -0700
X-CSE-ConnectionGUID: 9BoeZgeiSVGt9k62kL9qKg==
X-CSE-MsgGUID: 0rdFGsciR6C7Dm89EPIi5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63484029"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:59:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1sdpFk-0000000EhUZ-2AJ2;
	Tue, 13 Aug 2024 13:59:48 +0300
Date: Tue, 13 Aug 2024 13:59:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dillon Min <dillon.minfei@gmail.com>
Cc: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Priit Laes <plaes@plaes.org>, David Lechner <dlechner@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: State of affairs with Ilitek 9341 support
Message-ID: <Zrs8pEiOMIc_Q7bg@smile.fi.intel.com>
References: <ZXM9pG-53V4S8E2H@smile.fi.intel.com>
 <7c848801-cf7f-4293-8a29-084dd20efb8e@tronnes.org>
 <ZXcMTBKbHiuTLAfR@smile.fi.intel.com>
 <CAL9mu0+PDhFEWM7TKbMOQfKF0kSgGxo67qd1MRuCLpzq=d_Edg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL9mu0+PDhFEWM7TKbMOQfKF0kSgGxo67qd1MRuCLpzq=d_Edg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Dec 23, 2023 at 11:00:32AM +0800, Dillon Min wrote:
> On Mon, 11 Dec 2023 at 21:19, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Fri, Dec 08, 2023 at 09:18:20PM +0100, Noralf Trønnes wrote:
> > > On 12/8/23 17:00, Andy Shevchenko wrote:

> > > > Included authors and latest (non-white-space) contributors to the drivers
> > > > in question along with relevant mailing list and respective (active in the
> > > > area) maintainers.
> > > >
> > > > I already had risen the question in times when 4th (sic!) driver for the same
> > > > hardware was about to be pulled into upstream that we have to somehow reduce
> > > > the code base and unify device properties.
> > > >
> > > > So, the main question here "What is the plan and where are we now?"
> > > >
> > > > I admit that fbtft case is special as it supports, in particular, platform
> > > > device (parallel interface) and also well established in the embedded world.
> > > > What about the rest?
> > > >
> > > > N.B. Besides the fact that panel drivers are too OF-centric, which is bad
> > > > practice for the new kernel code in general and has to be stopped. I.o.w.
> > > > seeing of_property_*() or alike in the driver after ca. 2020 should be
> > > > immediate NAK unless it's very well justified why it may not be used on
> > > > non-OF systems.
> >
> > Noralf, thanks for your response, my comments below.
> >
> > TBH I would also like to hear from maintainers, because it seems they got
> > an additional burden for no benefit.
> >
> > > Last year drivers/gpu/drm/tiny/panel-mipi-dbi.c was added to support all
> > > MIPI DBI compatible (ili9341) SPI displays.
> > > It loads the initialisation commands from a firmware file. For more info
> > > see https://github.com/notro/panel-mipi-dbi/wiki.
> > >
> > > When I started on fbtft in 2013 I didn't know about MIPI DBI so I made
> > > some common bus access functions and one driver per controller and that
> > > driver had an initialisation sequence to match the panel I had. Then I
> > > discovered that displays using the same controller could have different
> > > init sequences so I added a Device Tree <init> property that could
> > > override the driver init.
> > >
> > > In 2015 fbtft was added to drivers/staging, but later that year fbdev
> > > was closed for new drivers so it was a dead end.
> > >
> > > I started to work on porting fbtft to DRM and almost 2 years later
> > > support for the MI0283QT panel (ILI9341) was added.
> > > I had now learned about MIPI DBI so a library to handle that was added.
> > > I had asked on the Device Tree ML about the <init> property and I was
> > > told that I couldn't have that which meant that I couldn't get away with
> > > having just one driver for the MIPI DBI compatible display panels as I
> > > was first hoping for.
> > >
> > > I was aware that there was a challenge going from fbtft to DRM because
> > > in fbtft there is support for all panel setups using the <init>
> > > property, but in DRM every panel needed support in a driver. So I
> > > started to look at adding Device Tree properties to describe the setup
> > > for one controller. This would make it easy to describe a new panel in
> > > Device Tree for a supported controller. Maxime Ripard came up with the
> > > idea to have the controller initialisation commands in a firmware file
> > > which meant that we could get away with having just one driver for all
> > > MIPI DBI SPI panels (which is the vast majority of these SPI pixel
> > > upload panels).
> > >
> > > This meant that SPI support could be removed from all the MIPI DBI
> > > compatible controllers in fbtft
> >
> > I believe it can't. Otherwise we _must_ provide the DT (device property)
> > parser that uses what is provided for fbtft SPI to be enabled in the other
> > driver.
> >
> > > since there's now a solution for them in
> > > DRM. The drivers themselves must stay since they also have parallel bus
> > > support which is lacking in DRM. My plan was to wait for panel-mipi-dbi
> > > to hit an LTS and then either prepare patches to remove MIPI DBI SPI
> > > support from fbtft or at least send an email to staging about the new
> > > driver.
> >
> > > Unfortunately my health problems got worse and many plans went
> > > out the window.
> >
> > Oh, sad to hear this, hope you will get better sooner than later!
> >
> > > ILI9341 DRM drivers
> > >
> > > - drivers/gpu/drm/tiny/mi0283qt.c
> > >   This was the first driver added for the MI0283QT panel series
> > >
> > > - drivers/gpu/drm/tiny/ili9341.c
> > >   Later ili9341 based panels was decided to be added to a controller
> > >   specific driver.
> >
> > Why was it appeared in the first place? :-(
> >
> > > - drivers/gpu/drm/tiny/panel-mipi-dbi.c
> > >   Generic MIPI DBI SPI driver that loads init commands from a firmware
> > >   file. It uses of_property_read_string_index() and
> > >   of_get_drm_panel_display_mode(). I don't know if it's possible to make
> > >   device_property_*() versions of those.
> >
> > Everything like this is possible, just somebody needs to fulfill that.
> > And as I said, new OF-centric code, has to be NAKed by default.
> >
> > > - drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> > >   This driver supports the MIPI DPI (RGB) interface on the controller.
> > >   Controller init is done over MIPI DBI SPI. The driver does also for
> > >   some reason support the same panel as the ili9341.c driver does.
> > >   So 2 drivers for the same panel...
> > >   Sidenote: It is possible to make a generic panel-mipi-dpi.c driver for
> > >   panels that use DPI for pixels and DBI for init loaded from a firmware
> > >   file.
> >
> > I wonder who has enough experience and time to at least point out or do
> > something about this...
> >
> > At least we can start combining the two in tinydrm, to reduce the variety.
> 
> I wrote drivers/gpu/drm/panel/panel-ilitek-ili9341.c to support ili9341
> on stm32f429-disco board via dbi or dpi.
> https://www.st.com/resource/en/schematic_pack/mb1075-f429i-c01_schematic.pdf
> 
> As one driver for one panel reason, so porting the mipi_dbi code and
> dts binding from tiny/ili9341.c
> It's true confused two driver for one panel in current kernel.
> I can remove the mipi_dbi code from panel-ilitek-ili9341.c or do something else.

FWIW, I have just sent this:
https://lore.kernel.org/r/20240813091258.1625646-1-andriy.shevchenko@linux.intel.com

> Anyway, I'd like to rewrite it based on the agreement.

-- 
With Best Regards,
Andy Shevchenko


