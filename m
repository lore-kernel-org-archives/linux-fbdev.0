Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCBBD50E
	for <linux-fbdev@vger.kernel.org>; Sat, 23 Dec 2023 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjcKyD3h"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7b7fe0ae57bso109272039f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 22 Dec 2023 19:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703300469; x=1703905269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8OoqAiM//Ec8KyRzYnGWKahzmDJ4khoTmwRNIjxv3I=;
        b=OjcKyD3h1ecJChZsyCOwi7c4YFsJ3907USl8DOpLjfAl2vFDmqJKGa/+EI5fUlVwk9
         w3zU0JXHuO/dffVMAsgyFdMfYLcv+3HbQ8wGhsZ2O5yR6wyfBpyyHlTce1iFRpk2tnA3
         2pweNCHnWGRUREhu9ys9hHOBaO7MZ8rNR2vyezmwndrcFpjTH5nKiNb6x7ul67Oah5oJ
         wLvhHKUAHDwIml2La0jU25VYOHDmOtEfpBan/3FoQslV2moyJf8f+/edlGco74KZNLcx
         gwLsObuCob18mpYtD/GkpMZVmANJEDWairWnE+lurQ42RXjX2+CFU7tREnQ1SMmgQRbE
         FaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703300469; x=1703905269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8OoqAiM//Ec8KyRzYnGWKahzmDJ4khoTmwRNIjxv3I=;
        b=B+1o+RxNql71l/S17H1mc9w0hOwVLsMdAFWSh0n9i3m0ptJ0VyD/zQ35PAufhE1me9
         b7ez9ANJ6Xz7O+hTLpRuzY9Q/izSAKBEAjc4/MM5WcYXWrwiVZbwpp8DUWK4DwHatvl8
         iNymuuBctV+9DydU1Hbm9Buql+epkGN4/PnwlDPQXuDpwypLeRqW2nVjlSNjMhd2DyHr
         kvpO2oHm+HBvT205aAmboEM1Ruc9sAxMqSbHgpxX+qsY6Hygg4swRSm8v+aiAxHVlAwS
         dVk0i35lLawKJ8aAd7u+g1gweexHS1nWL1oKdxPrpk7YhwjhIzLEfjliFq5tQigLW6Qq
         ngwQ==
X-Gm-Message-State: AOJu0YwA+rCJiNSjon/mHX/cllYodSssb1Ort1+mmsxMDK7QjYa+ikmt
	m7fzjPtEdZipHWKv4EaoKowDQTgWeuK4Iy4HTlg=
X-Google-Smtp-Source: AGHT+IGGQNHVY11KYqlpzCvOtz5O3eCysFRigaLzsJ7bhd+IOCocMo+8AMyQ75OsMpXnCU/hkwmTTbKD9TikM+6vv+4=
X-Received: by 2002:a5e:a803:0:b0:7b7:fde0:ccfb with SMTP id
 c3-20020a5ea803000000b007b7fde0ccfbmr2699501ioa.9.1703300468716; Fri, 22 Dec
 2023 19:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXM9pG-53V4S8E2H@smile.fi.intel.com> <7c848801-cf7f-4293-8a29-084dd20efb8e@tronnes.org>
 <ZXcMTBKbHiuTLAfR@smile.fi.intel.com>
In-Reply-To: <ZXcMTBKbHiuTLAfR@smile.fi.intel.com>
From: Dillon Min <dillon.minfei@gmail.com>
Date: Sat, 23 Dec 2023 11:00:32 +0800
Message-ID: <CAL9mu0+PDhFEWM7TKbMOQfKF0kSgGxo67qd1MRuCLpzq=d_Edg@mail.gmail.com>
Subject: Re: State of affairs with Ilitek 9341 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Priit Laes <plaes@plaes.org>, 
	David Lechner <dlechner@baylibre.com>, Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Dec 2023 at 21:19, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Dec 08, 2023 at 09:18:20PM +0100, Noralf Tr=C3=B8nnes wrote:
> > On 12/8/23 17:00, Andy Shevchenko wrote:
> > > Included authors and latest (non-white-space) contributors to the dri=
vers
> > > in question along with relevant mailing list and respective (active i=
n the
> > > area) maintainers.
> > >
> > > I already had risen the question in times when 4th (sic!) driver for =
the same
> > > hardware was about to be pulled into upstream that we have to somehow=
 reduce
> > > the code base and unify device properties.
> > >
> > > So, the main question here "What is the plan and where are we now?"
> > >
> > > I admit that fbtft case is special as it supports, in particular, pla=
tform
> > > device (parallel interface) and also well established in the embedded=
 world.
> > > What about the rest?
> > >
> > > N.B. Besides the fact that panel drivers are too OF-centric, which is=
 bad
> > > practice for the new kernel code in general and has to be stopped. I.=
o.w.
> > > seeing of_property_*() or alike in the driver after ca. 2020 should b=
e
> > > immediate NAK unless it's very well justified why it may not be used =
on
> > > non-OF systems.
>
> Noralf, thanks for your response, my comments below.
>
> TBH I would also like to hear from maintainers, because it seems they got
> an additional burden for no benefit.
>
> > Last year drivers/gpu/drm/tiny/panel-mipi-dbi.c was added to support al=
l
> > MIPI DBI compatible (ili9341) SPI displays.
> > It loads the initialisation commands from a firmware file. For more inf=
o
> > see https://github.com/notro/panel-mipi-dbi/wiki.
> >
> > When I started on fbtft in 2013 I didn't know about MIPI DBI so I made
> > some common bus access functions and one driver per controller and that
> > driver had an initialisation sequence to match the panel I had. Then I
> > discovered that displays using the same controller could have different
> > init sequences so I added a Device Tree <init> property that could
> > override the driver init.
> >
> > In 2015 fbtft was added to drivers/staging, but later that year fbdev
> > was closed for new drivers so it was a dead end.
> >
> > I started to work on porting fbtft to DRM and almost 2 years later
> > support for the MI0283QT panel (ILI9341) was added.
> > I had now learned about MIPI DBI so a library to handle that was added.
> > I had asked on the Device Tree ML about the <init> property and I was
> > told that I couldn't have that which meant that I couldn't get away wit=
h
> > having just one driver for the MIPI DBI compatible display panels as I
> > was first hoping for.
> >
> > I was aware that there was a challenge going from fbtft to DRM because
> > in fbtft there is support for all panel setups using the <init>
> > property, but in DRM every panel needed support in a driver. So I
> > started to look at adding Device Tree properties to describe the setup
> > for one controller. This would make it easy to describe a new panel in
> > Device Tree for a supported controller. Maxime Ripard came up with the
> > idea to have the controller initialisation commands in a firmware file
> > which meant that we could get away with having just one driver for all
> > MIPI DBI SPI panels (which is the vast majority of these SPI pixel
> > upload panels).
> >
> > This meant that SPI support could be removed from all the MIPI DBI
> > compatible controllers in fbtft
>
> I believe it can't. Otherwise we _must_ provide the DT (device property)
> parser that uses what is provided for fbtft SPI to be enabled in the othe=
r
> driver.
>
> > since there's now a solution for them in
> > DRM. The drivers themselves must stay since they also have parallel bus
> > support which is lacking in DRM. My plan was to wait for panel-mipi-dbi
> > to hit an LTS and then either prepare patches to remove MIPI DBI SPI
> > support from fbtft or at least send an email to staging about the new
> > driver.
>
> > Unfortunately my health problems got worse and many plans went
> > out the window.
>
> Oh, sad to hear this, hope you will get better sooner than later!
>
> > ILI9341 DRM drivers
> >
> > - drivers/gpu/drm/tiny/mi0283qt.c
> >   This was the first driver added for the MI0283QT panel series
> >
> > - drivers/gpu/drm/tiny/ili9341.c
> >   Later ili9341 based panels was decided to be added to a controller
> >   specific driver.
>
> Why was it appeared in the first place? :-(
>
> > - drivers/gpu/drm/tiny/panel-mipi-dbi.c
> >   Generic MIPI DBI SPI driver that loads init commands from a firmware
> >   file. It uses of_property_read_string_index() and
> >   of_get_drm_panel_display_mode(). I don't know if it's possible to mak=
e
> >   device_property_*() versions of those.
>
> Everything like this is possible, just somebody needs to fulfill that.
> And as I said, new OF-centric code, has to be NAKed by default.
>
> > - drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> >   This driver supports the MIPI DPI (RGB) interface on the controller.
> >   Controller init is done over MIPI DBI SPI. The driver does also for
> >   some reason support the same panel as the ili9341.c driver does.
> >   So 2 drivers for the same panel...
> >   Sidenote: It is possible to make a generic panel-mipi-dpi.c driver fo=
r
> >   panels that use DPI for pixels and DBI for init loaded from a firmwar=
e
> >   file.
>
> I wonder who has enough experience and time to at least point out or do
> something about this...
>
> At least we can start combining the two in tinydrm, to reduce the variety=
.
>

I wrote drivers/gpu/drm/panel/panel-ilitek-ili9341.c to support ili9341
on stm32f429-disco board via dbi or dpi.
https://www.st.com/resource/en/schematic_pack/mb1075-f429i-c01_schematic.pd=
f

As one driver for one panel reason, so porting the mipi_dbi code and
dts binding from tiny/ili9341.c
It's true confused two driver for one panel in current kernel.
I can remove the mipi_dbi code from panel-ilitek-ili9341.c or do something =
else.

Anyway, I'd like to rewrite it based on the agreement.

> --
> With Best Regards,
> Andy Shevchenko
>
>
