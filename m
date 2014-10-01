From: Mark Brown <broonie@kernel.org>
Date: Wed, 01 Oct 2014 12:32:50 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141001123250.GY4273@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="agGyne4gKHM29dDu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
In-Reply-To: <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--agGyne4gKHM29dDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2014 at 01:10:46PM +0200, Javier Martinez Canillas wrote:
> On Wed, Oct 1, 2014 at 9:41 AM, Thierry Reding <thierry.reding@gmail.com> wrote:

> > Okay, that's what I meant. It seems rather odd to add a PMIC DT node but
> > omit the description of the regulators that it exposes. Unless the
> > regulators are truly unused, as in not connected to any peripherals.

> Agreed, I added similar PMIC support to other Chromebooks (Peach Pit
> and Pi) DTS and for me it made totally sense to add nodes for all the
> regulators that are connected to peripherals according to the board
> schematic. Specially since the framework is smart enough to disable
> any regulator that is not used.

> After all, a DT is meant to describe the hardware, so how can possibly
> be an issue to add more details about the hw in a DTS?

> If something is working relying on parts of the hw on not being
> described, then is essentially relying on side-effects and
> implementation details which are bound to be broken anyways.

It's not a problem to describe the hardware, it's a problem to describe
the hardware inaccurately.  If you add something and explicitly tell the
kernel that nothing needs it then it shouldn't be a surprise that it
gets turned off.

> > With described as unused you mean they have a node in DT, so constraints
> > are applied and all that, but no driver actually uses them?

> Adding your resources (clock, regulators, etc) incrementally and only
> when the driver for the device that use these resources is available,
> will only make adding support for a new platform slower IMHO since
> there will be more patches to be posted, reviewed and merged.

So don't do that if you're worried about it then, provide the bits of DT
that hook everything up from the start or otherwise describe things as
being in use.

--agGyne4gKHM29dDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUK/RyAAoJECTWi3JdVIfQUdgIAIRDTvijaAlq6H2PpJai5BsF
PyUFjditK0KqPN+EnbCaw+W5jTH2QXS1XzuffqaDksKflVxB8XsYyPc7XQ++jzOE
7obse0CVJYNr/P8pXAiqqn4j1qSf6I3os2nmG1DsGxlKv0PFFHqpmS/f1x0ZXBEg
RmKJV+5j3lGy+LxQhkD2y3NX5m/8wHDNoenbMOAPJ0aKks/K+HLbAcxN8KlWj5AB
h2HwBE/fP9SdpTdFTKABwUF421QTCsnWMz/aD9vyaI4+jIeMxpt0jqCzuti3hYsO
LIHV2h/GXkumWYsr+uVtingpWJ5FCj1+jN1moPIi4LwBRIg0OrYgxBhPcHw4nww=
=SM5U
-----END PGP SIGNATURE-----

--agGyne4gKHM29dDu--
