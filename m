From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Thu, 13 Sep 2012 08:32:38 +0000
Subject: Re: [PATCH v6 1/4] Runtime Interpreted Power Sequences
Message-Id: <20120913083238.GB12259@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ftEhullJWpWg/VHq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <1464760.6eqxJ2IzZ2@percival> <1347517377.7471.23.camel@lappyti>
 <2689722.93BQTh4lSC@percival> <1347519249.7471.42.camel@lappyti>
 <20120913070012.GC6180@pengutronix.de>
 <1347519807.7471.45.camel@lappyti>
 <20120913072920.GA11459@avionic-0098.mockup.avionic-design.de>
 <1347523218.3014.4.camel@deskari>
In-Reply-To: <1347523218.3014.4.camel@deskari>
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 13, 2012 at 11:00:18AM +0300, Tomi Valkeinen wrote:
> Yes, I think the backlight and the panel should be considered separate
> devices. Just like, say, a touch screen and a panel may happen to be in
> the same display module, a backlight and a panel can be in the same
> display module. They are still separate, independent things, although
> they are, of course, used together.

Still, as Alex mentioned, there may be some dependency between the panel
and the backlight, so we may need to have some kind of connection. I
haven't had much time to look at the panel subsystem, but perhaps it
should provide for this.

I obviously don't know every panel and backlight combination out there,
but isn't the dependency more of a usability nature. What I mean is that
the panel will work even if you switch the backlight on immediately,
just that the panel might take some time to properly display data and
therefore the backlight should remain powered off so the user doesn't
see garbage. Or are there really any functional dependencies?

Thierry

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQUZomAAoJEN0jrNd/PrOhoxkP/1NcMahOa2vJssXtRd00kKjt
43a6kdaicffWOSgNh6grb8KYv1yc3obztLPrDXZK+mEYI4BZRw4HSR+xkoRHH1B7
tYBbrnB7gwJV3aI1kEbF2O78SPIuk6OcdpMcF1G7vYV/W9aI04GTUMxbeARSppQI
omA8Fsp6r0XtMYMeupBXRBAgrXB0UB7SESrB2ZRYCYK/Ok7+lZ/6A9Wfals7Cep7
ZdGa0PsXBp9XqEKiG3xyW3Z1HEM2Xjq306OoxWjci8kyy3s2oIerAj2/d087fkWY
brt/hTKIxPUYPRorYFgT5O+LyHhPQDr8GER11kqRRsaYrrV1aQ/DH/0n3dTtD3Ts
TFume+Cu9gDLJ69yh6Iyohf5NqhQTmeERR8h8lwWfLZjhi7ksxl3wwEA1BorT2ly
MQe8FRiJEvQLnneYjPlcIvjCGW1h+NpjmRdRAiS7XsRec3O/t+U71MxY/nNkxR/u
aUXtvVBVklTOSzhqsU2H3BSYHw2F/Ngvu9TkqbBz/YRtzwSroVMJMeiU8DRGl0Hs
gY6bogMqy9UT+WE4xtsVEm3h7K6tlBkNgX9ZVSr7OcJ1kzH2YtKQ32DI3MVXl4DJ
xJvsMEeRgBuYFFtY35mG2zGx04nLdcUDoVoeNS2jmTfxW7dWHdIsGveyGU7ANWF6
EFnBvzqsTwC2AaDlAJJz
=M0St
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
