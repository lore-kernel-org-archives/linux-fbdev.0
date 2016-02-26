From: Mark Brown <broonie@kernel.org>
Date: Fri, 26 Feb 2016 12:22:48 +0000
Subject: Re: [PATCH v2 3/3] fbdev: omap2: panel-dpi: implement support for a vcc regulator
Message-Id: <20160226122248.GQ18327@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nBU79UIGV2yWqiI+"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-fbdev@vger.kernel.org


--nBU79UIGV2yWqiI+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 01:10:08PM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Feb 26, 2016 at 12:13:07PM +0200, Tomi Valkeinen wrote:

> > > That would make the specification of a vcc supply obligatory IIUC. (Y=
es,
> > > the semantic difference between regulator_get vs. regulator_get_optio=
nal
> > > is reversed when comparing to gpio_get vs. gpio_get_optional.)

Not really, in both cases the _optional() case is for the case where the
requested resource may reasonably be absent.

> > So, is regulator_get_optional() meant for cases where the device can
> > truly function without the supply in question? And regulator_get()
> > should be used when the device needs the supply, even if the supply
> > cannot be controlled via SW, and thus we may not even have the supply
> > visible in the SW side (leading to using dummy regulator)?

> Yeah, I think this is the right picture.

Yes, exactly.  Even in cases where supplies could potentially be
software controlled frequently system constraints make it impossible to
actually change their state so the consumer should not normally assume
that a disable will actually happen.

--nBU79UIGV2yWqiI+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW0EOPAAoJECTWi3JdVIfQVf0H/0tQoSxbRCVeF/SqY3W/evEh
UjeISwSG1Ne0XEiCTULz0vvJmzcsg24orjYVeI8zvJjT6Vz5lEQDcHwrgwg5qiTv
i88UD/Zy3TlUf+hOPp1Ui8Ai0rRyEvS8Q/czr1TWdbb8Ot651s4+f1x//xaoR5rE
J/hzQhylAZCv8VyKrdG1eOGMmKOeXQUubY7MSI8vDnlJ2zy/t1iHwKedQ6j8EHm0
UME4+DMqCc607w8JxQAUeMkztnVL6M/Ar6VAPiAjc+O1ZQ1p9up4r38rDY+NcMZ4
QAT/QO7CREjMyOxo17mWjpXaoc1V0fKC+m3cQvVjQBQuixBwQrnNqj+qiCyPNlI=
=Ie+z
-----END PGP SIGNATURE-----

--nBU79UIGV2yWqiI+--
