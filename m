From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 30 Sep 2014 05:09:24 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930050923.GB29874@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bCsyhTFzCvuiizWE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
In-Reply-To: <20140929155517.GR16977@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 04:55:17PM +0100, Mark Brown wrote:
> On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:
[...]
> > The same thing is going to happen with simplefb for your device. If you
> > later realize that you need a regulator to keep the panel going, you'll
> > have to add code to your firmware to populate the corresponding
> > properties, otherwise the regulator will end up unused and will be
> > automatically disabled. At the same time you're going to break upstream
> > for all users of your old firmware because it doesn't add that property
> > yet.
>=20
> > And the same will continue to happen for every new type of resource
> > you're going to add.
>=20
> So long as we're ensuring that when we don't start supporting resources
> without DT additions or at least require DT additions to actively manage
> them (which can then include simplefb hookup) we should be fine.

I'm not sure I understand what you mean. If we add a driver for the PMIC
that exposes these regulators and then add a DT node for the PMIC, we'd
still need to fix the firmware to generate the appropriate DT properties
to allow simplefb to enable the regulators.

So unless firmware is updated at the same time, regulators will get
disabled because they are unused.

Thierry

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKjsDAAoJEN0jrNd/PrOh0qsP/RuWHN2ABL2YPtszuIaAjkHP
Hr1pTvhT3G2AckjkzZf5XAFKBLa+/D5oH04EfAKpZAIe1th8Oej2mH+4m5to8+ha
Mu2NtVcWB2CMCx049Z2DCb4aMMlZ9nvkTFgBIbqVGG+ZtnQlLvwvF5EHmz49um9O
wWFnridOEOGav2QhbTC3UHyw18t5rDQ7gW1iRkRmQrE518mwYR5PpqgEtfdmDSbc
EWERDBvpsYr3Gc5KyHtKSi6GA1YLHbS1ivTlWzr6rDEMz5U5Kn8Zve/XzvbWPFcG
VSXZGjtNY0U3rrK2Q3rrnY+qQJ6rn4oLcY7sYHwglBPjn6BpMBT236Y1KY1ubYRm
qelCRxncWrFBRjBbnQQRXjr+If1xJtwfRHpg3IFXM4i5ds5zoFsZHgPuEWSB8TUW
7hIwHdl6GCcC4PeTm3iT8d1VSs8soktLI4JKkYUiTJXnphRjr+2U8TTiMPtZ6Yak
ptQ7RzeDwmoBhs5qiK5lPkSLtY1CIiuvIMHX1W8tSofPhhuL3gUzUxZziqlwGIQi
uDUTCokX9Yl/+7hA2kdUl0KzbVZ8qrqDHXbjnIUtaNxD84MGVm7WG0uZFhkRbxep
EcreWVEdizAyM6T4VXAokEXXVQN5p6hY7cM0ot7tB+TSUSotpEoMTA9wypHuvlnK
OwaTFv4Auncd/eMNV+Ys
=APvt
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
