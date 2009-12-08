From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 08 Dec 2009 09:21:36 +0000
Subject: Re: [PATCH 0/2] [RESEND] Amstrad Delta: add support for LCD
Message-Id: <1260264096.2342.104.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <200911231857.55566.jkrzyszt@tis.icnet.pl>
	 <200912051454.52966.jkrzyszt@tis.icnet.pl>
	 <20091207213250.GI24013@atomide.com>
In-Reply-To: <20091207213250.GI24013@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ext Tony Lindgren <tony@atomide.com>, "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2009-12-07 at 22:32 +0100, ext Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091205 05:54]:
> > Monday 23 November 2009 18:57:51 Janusz Krzysztofik napisa=C5=82(a):
> > > Initialy submitted on 2009-11-16
> > > (http://www.spinics.net/lists/linux-omap/msg20629.html).
> > > Resendig due to fbdev mailing list address changed.
> > >
> > > The series consists of 2 patches:
> > >
> > >  [PATCH 1/2] omapfb: lcd_ams_delta: add support for contrast control
> > >  [PATCH 2/2] OMAP: ams_delta_defconfig: enable LCD class device suppo=
rt
> > >
> > > It is intended for 2.6.33, if it's not too late.
> >=20
> > Hi,
> >=20
> > Now that Tony has changed the series status from New to Awaiting Upstre=
am in=20
> > his patchwork queue[1][2], chances of getting it in throungh linux-omap=
 tree,=20
> > like a few other omapfb related patches managed to do lately, seem fall=
ing=20
> > down drastically to me if still not answered by anyone involved in omap=
fb=20
> > development.
> >=20
> > Imre,
> > Could you please take the patches, or give your ack for Tony to take th=
em, or=20
> > just point me on the right way to the get them integrated or NAKed, if =
none=20
> > of the former is?
> >=20
> > Tomi,
> > I am not sure if you are the right person for bothering here, but maybe=
 you=20
> > could give your comments that would help pushing it forward?
>=20
> I'd prefer Tomi to merge all the drivers/video/omap code rather
> than merge it via linux-omap tree. Ideally with an ack from
> Imre where possible.

And I, on the other hand, would like to keep away from the old omapfb
driver =3D).

Imre, do you still want to be the maintainer of the old omapfb, or how
should we handle it? I didn't have any plans to maintain it, but then
again, perhaps it wouldn't be too much of a burden to have the
(hopefully) few patches for old omapfb in the DSS2 tree.

 Tomi


